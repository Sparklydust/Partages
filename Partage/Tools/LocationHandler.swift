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
  var distanceInMetersToItem: Double = .zero
}

//MARK: - Get user location accuracy to best
extension LocationHandler {
  func getUserLocationAccuracy() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func userLocation() -> CLLocation {
    let userLocation = locationManager.location
    return userLocation ?? CLLocation(latitude: CLLocationDegrees(exactly: 0.0)!, longitude: CLLocationDegrees(exactly: 0.0)!)
  }
}

//MARK: - #1 Use this method to setup user location on any Partage map view
extension LocationHandler {
  func setupUserLocationAtBest(onto mapView: MKMapView, byMeters: CLLocationDistance, vc: UIViewController) {
    setupLocationServices(on: mapView, vc: vc)
    centerViewOnUserLocation(onto: mapView, byMeters: byMeters)
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
  func convertLatLonToAnAdress(vc: MapViewVC) {
    let latitude = annotation.coordinate.latitude
    let longitude = annotation.coordinate.longitude
    
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
      let coordinates = placemark.location
      let streetNumber = placemark.subThoroughfare ?? ""
      let streetName = placemark.thoroughfare ?? ""
      let postalCode = placemark.postalCode ?? ""
      let cityName = placemark.locality ?? ""
      let countryName = placemark.country ?? ""
      
      DispatchQueue.main.async {
        // Sending the address and coordinates to Donor VC
        vc.delegate?.addressReceived(coordinates: coordinates!, streetNumber: streetNumber, streetName: streetName, postalCode: postalCode, cityName: cityName, countryName: countryName)
      }
    }
  }
}

//MARK - #4 Method to center map view around the meeting point
extension LocationHandler {
  func centerView(around meetingPoint: CLLocationCoordinate2D, onto mapView: MKMapView) {
    let region = MKCoordinateRegion.init(center: meetingPoint, latitudinalMeters: 25, longitudinalMeters: 50)
    mapView.setRegion(region, animated: true)
  }
}

//MARK: - #5.1 Get user direction from user location to pinned location
extension LocationHandler {
  func getDirectionFromUserToPinnedLocation(on mapView: MKMapView, latitude: Double, longitude: Double, vc: UIViewController) {
    guard let location = locationManager.location?.coordinate else {
      DispatchQueue.main.async {
        vc.goToUserSettings(title: .locationOff, message: .getDirectionIssue, buttonName: .settings)
      }
      return
    }
    let request = createDirectionRequest(from: location, to: latitude, and: longitude)
    let directions = MKDirections(request: request)
    
    directions.calculate {
      (response, error) in
      guard let response = response else {
        vc.showAlert(title: .error, message: .noDirectionsCalculated)
        return
      }
      for route in response.routes {
        mapView.addOverlay(route.polyline)
        mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: .zero, left: 100, bottom: .zero, right: 100), animated: true)
        
        self.distanceInMetersToItem = route.distance
      }
    }
  }
}

//MARK: - #6 Method to add an annotation on any map
extension LocationHandler {
  func itemAnnotationShown(on mapView: MKMapView, located locationCoordinates: CLLocationCoordinate2D) {
    annotation.coordinate = locationCoordinates
    annotation.title = StaticLabel.meetingPoint.rawValue
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotation(annotation)
    
    let coordinate = locationCoordinates
    let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
  
  func itemAnnotationShown(on mapView: MKMapView, latitude: Double, longitude: Double) {
    let locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    annotation.coordinate = locationCoordinates
    annotation.title = StaticLabel.meetingPoint.rawValue
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotation(annotation)
    
    let coordinate = locationCoordinates
    let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }

}

//MARK - Method to center map view around the user location
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
      DispatchQueue.main.async {
        vc.goToUserSettings(title: .locationOff, message: .locationOff, buttonName: .settings)
      }
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
    case .denied:
      DispatchQueue.main.async {
        vc.goToUserSettings(title: .locationOff, message: .locationOff, buttonName: .settings)
      }
    case .restricted:
      vc.showAlert(title: .restricted, message: .restricted)
    case .notDetermined:
      DispatchQueue.main.async {
        self.locationManager.requestWhenInUseAuthorization()
      }
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

//MARK: - Method to create direction request
extension LocationHandler {
  func createDirectionRequest(from coordinate: CLLocationCoordinate2D, to meetingPointLat: CLLocationDegrees, and meetingPointLon: CLLocationDegrees) -> MKDirections.Request {
    let startingLocation = MKPlacemark(coordinate: coordinate)
    let destination = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: meetingPointLat, longitude: meetingPointLon))

    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: startingLocation)
    request.destination = MKMapItem(placemark: destination)
    request.transportType = .walking
    request.requestsAlternateRoutes = true
    return request
  }
}

//MARK: - Method to open Apple Map App with user to meeting point direction
extension LocationHandler {
  func openAppleMapApp(itemLatitude: Double, itemLongitude: Double) {
    let source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.location!.coordinate))
    source.name = StaticLabel.userPosition.rawValue
    
    let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: itemLatitude, longitude: itemLongitude)))
    destination.name = StaticLabel.meetingPoint.rawValue
    
    MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
  }
}

//MARK: - Return user distance between its location to the meeting point
extension LocationHandler {
  func getDistanceFromUserToMeetingPoint(_ meetingPointLatitude: Double, _ meetingPointLongitude: Double, vc: UIViewController) -> Double {
    if let location = locationManager.location?.coordinate {
      let request = createDirectionRequest(from: location, to: meetingPointLatitude, and: meetingPointLongitude)
      let directions = MKDirections(request: request)
      directions.calculate {
        (response, error) in
        guard let response = response else {
          vc.showAlert(title: .error, message: .noDirectionsCalculated)
          return
        }
        for route in response.routes {
          self.distanceInMetersToItem = route.distance
        }
      }
    }
    else {
      DispatchQueue.main.async {
        vc.goToUserSettings(title: .locationOff, message: .getDirectionIssue, buttonName: .settings)
      }
    }
    return distanceInMetersToItem
  }
}
