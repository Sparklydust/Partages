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
  var meetingPoint = CLLocation()
  
  let metersAroundUser: CLLocationDistance = 500
  var distanceInMetersToItem: Double = 0
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

//MARK - #2 Use this method in tap gesture to add a pin on map view and get that point coordinates
extension LocationHandler {
  func userPinAndGetCoordinates(of meetingPoint: StaticLabel ,on mapView: MKMapView, sender: UILongPressGestureRecognizer) {
    let location = sender.location(in: mapView)
    let locationCoordinates = mapView.convert(location, toCoordinateFrom: mapView)
    
    annotation.coordinate = locationCoordinates
    annotation.title = meetingPoint.rawValue
    
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotation(annotation)
  }
}

//MARK: - #3 Use this method to convert pin latitude and longitude to a physical address
extension LocationHandler {
  func convertLatLonToAnAdress(vc: UIViewController) {
    var latitude = annotation.coordinate.latitude
    var longitude = annotation.coordinate.longitude
    
    meetingPoint = CLLocation.init(latitude: latitude, longitude: longitude)
    
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(meetingPoint) { [weak self]
      (placemarks, error) in
      guard self != nil else { return }
      if let _ =  error {
        vc.showAlert(title: .error, message: .locationIssue)
        return
      }
      guard let placemark = placemarks?.first else {
        vc.showAlert(title: .error, message: .locationIssue)
        return
      }
      if let location = placemark.location {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
      }
      let streetName = placemark.thoroughfare ?? ""
      let streetNumber = placemark.subThoroughfare ?? ""
      let postalCode = placemark.postalCode ?? ""
      let cityName = placemark.locality ?? ""
      let countryName = placemark.country ?? ""
      DispatchQueue.main.async {
        print("""
          
          Latitude is: \(latitude)
          Longitute is: \(longitude)
          
          \(streetNumber) \(streetName)
          \(postalCode) \(cityName)
          \(countryName)
          
          """)
      }
    }
  }
}

//MARK: - #4.1 Get user direction from user location to pinned location
extension LocationHandler {
  func getDirectionFromUserToPinnedLocation(on mapView: MKMapView ,vc: UIViewController) {
    guard let location = locationManager.location?.coordinate else {
      vc.goToUserSettings(title: .locationOff, message: .getDirectionIssue, buttonName: .settings)
      return
    }
    let request = createDirectionRequest(from: location, to: meetingPoint.coordinate.latitude, and: meetingPoint.coordinate.longitude)
    let directions = MKDirections(request: request)
    
    directions.calculate {
      (response, error) in
      guard let response = response else {
        vc.showAlert(title: .error, message: .noDirectionsCalculated)
        return
      }
      for route in response.routes {
        mapView.addOverlay(route.polyline)
        mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        
        self.distanceInMetersToItem = route.distance
      }
    }
  }
  
  //MARK: - #4.2 Method to use on the proper vc to display the directions in a blue line
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
    renderer.strokeColor = .mainBlue
    return renderer
  }
}

//MARK - Method to enter map view around the user location
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
      vc.goToUserSettings(title: .locationOff, message: .locationOff, buttonName: .settings)
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
      vc.goToUserSettings(title: .locationOff, message: .locationOff, buttonName: .settings)
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .authorizedAlways:
      break
    @unknown default:
      fatalError()
    }
  }
}

//MARK: - Method to start tracking user location
extension LocationHandler {
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

//MARK: - Method to create direction request
extension LocationHandler {
  func createDirectionRequest(from coordinate: CLLocationCoordinate2D, to meetingPointLat: CLLocationDegrees, and meetingPointLon: CLLocationDegrees) -> MKDirections.Request {
    let startingLocation = MKPlacemark(coordinate: coordinate)
    let destination = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: meetingPointLat, longitude: meetingPointLon))

    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: startingLocation)
    request.destination = MKMapItem(placemark: destination)
    request.transportType = .any
    request.requestsAlternateRoutes = true
    return request
  }
}
