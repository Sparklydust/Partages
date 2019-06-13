//
//  LocationHandler.swift
//  Partage
//
//  Created by Roland Lariotte on 12/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import CoreLocation
import MapKit

class LocationHandler: CLLocationManager {
  static let shared = LocationHandler()
  
  let locationManager = CLLocationManager()
  let annotation = MKPointAnnotation()
  
  let metersAroundUser: CLLocationDistance = 500
}

//MARK: - Get user location accuracy to best
extension LocationHandler {
  func getUserLocationAccuracy() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
}

//MARK: - #1 Use this method to setup user location on any Partage map view
extension LocationHandler {
  func setupUserLocationAtBest(onto mapView: MKMapView, byMeters: CLLocationDistance, vc: UIViewController) {
    setupLocationServices(on: mapView, vc: vc)
    centerViewOnUserLocation(onto: mapView, byMeters: byMeters)
    checkLocationAuthorization(for: mapView, vc: vc)
    userChangeLocationAuthorization(for: mapView, vc: vc)
  }
}

//MARK - #2 Use this in tap gesture to add a pin on map view and get that point coordinates
extension LocationHandler {
  func userPinAndGetCoordinates(of meetingPoint: StaticLabel ,on mapView: MKMapView, sender: UILongPressGestureRecognizer) {
    let location = sender.location(in: mapView)
    let locationCoordinates = mapView.convert(location, toCoordinateFrom: mapView)
    
    //let annotation = MKPointAnnotation()
    annotation.coordinate = locationCoordinates
    annotation.title = meetingPoint.rawValue
    
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotation(annotation)
  }
}

// Center map view around the user location
extension LocationHandler {
  func centerViewOnUserLocation(onto mapView: MKMapView, byMeters distance: CLLocationDistance) {
    if let location = locationManager.location?.coordinate {
      let region = MKCoordinateRegion.init(center: location, latitudinalMeters: distance, longitudinalMeters: distance)
      mapView.setRegion(region, animated: true)
    }
  }
}

//MARK: - Checks if location services in general settings is on
extension LocationHandler {
  func setupLocationServices(on mapView: MKMapView, vc: UIViewController) {
    if CLLocationManager.locationServicesEnabled() {
      getUserLocationAccuracy()
      checkLocationAuthorization(for: mapView, vc: vc)
    }
    else {
      showAlert(vc: vc, title: .locationOff, message: .locationOff, buttonName: .settings)
    }
  }
}

//MARK: - Center map view when the user move location
extension LocationHandler {
  func userDidUpdateLocation(on mapView: MKMapView) {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let location = locations.last else { return }
      let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
      let region = MKCoordinateRegion.init(center: center, latitudinalMeters: metersAroundUser, longitudinalMeters: metersAroundUser)
      mapView.setRegion(region, animated: true)
    }
  }
}

//MARK: - Check location authorization status and act depending on the result
extension LocationHandler {
  func checkLocationAuthorization(for mapView: MKMapView, vc: UIViewController) {
    
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      startTrackingUserLocation(on: mapView)
    case .denied, .restricted:
      showAlert(vc: vc, title: .locationOff, message: .locationOff, buttonName: .settings)
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .authorizedAlways:
      break
    @unknown default:
      fatalError()
    }
  }
  
  func startTrackingUserLocation(on mapView: MKMapView) {
    mapView.showsUserLocation = true
    centerViewOnUserLocation(onto: mapView, byMeters: metersAroundUser)
    locationManager.startUpdatingLocation()
  }
}

//MARK: - User Change location authorization method
extension LocationHandler {
  func userChangeLocationAuthorization(for mapView: MKMapView, vc: UIViewController) {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      checkLocationAuthorization(for: mapView, vc: vc)
    }
  }
}

// Method to use UIAlerts in Location Handler
extension LocationHandler {
  func showAlert(vc: UIViewController, title: AlertTitle, message: AlertMessage, buttonName: ButtonName) {
    vc.goToUserSettings(title: title, message: message, buttonName: buttonName)
  }
}
