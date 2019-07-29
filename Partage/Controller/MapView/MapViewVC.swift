//
//  MapViewVC.swift
//  Partage
//
//  Created by Roland Lariotte on 12/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewVC: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var saveLocationButton: UIButton!
  
  let locationManager = CLLocationManager()
  
  let generator = UIImpactFeedbackGenerator(style: .light)
  let aroundUserLocation: CLLocationDistance = 500
  
  var delegate: CanReceiveItemAddressDelegate?
  var donorItemLatitude: Double = .zero
  var donorItemLongitude: Double = .zero
  var buttonName: ButtonName = .saveMeetingPoint
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    
    guard donorItemLatitude != .zero && donorItemLongitude != .zero else { return }
    LocationHandler.shared.getDirectionFromUserToPinnedLocation(on: mapView, latitude: donorItemLatitude, longitude: donorItemLongitude, vc: self)
    LocationHandler.shared.itemAnnotationShown(on: mapView, latitude: donorItemLatitude, longitude: donorItemLongitude)
  }
}

//MARK: - Buttons actions
extension MapViewVC {
  //MARK: Save location button action
  @IBAction func saveLocationButtonAction(_ sender: Any) {
    guard buttonName == .saveMeetingPoint else {
      LocationHandler.shared.openAppleMapApp(itemLatitude: donorItemLatitude, itemLongitude: donorItemLongitude)
      return
    }
    LocationHandler.shared.convertLatLonToAnAdress(vc: self)
    navigationController?.popViewController(animated: true)
  }
  
  //MARK: Long press gesture recognizer add pin with a vibration
  @IBAction func addPinLongPressGesture(_ sender: UILongPressGestureRecognizer) {
    LocationHandler.shared.userPinAndGetCoordinates(of: .meetingPoint, on: mapView, sender: sender)
    generator.impactOccurred()
  }
}

//MARK: - Main setup
extension MapViewVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupNavigationController()
    setupSaveLocationButton()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
  
  //MARK: All delegates
  func setupAllDelegates() {
    mapView.delegate = self
    locationManager.delegate = self
  }
}

//MARK: - Setup navigation controller design
extension MapViewVC {
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup save place button design
extension MapViewVC {
  func setupSaveLocationButton() {
    saveLocationButton.commonDesign(title: buttonName)
  }
}

//MARK: - User change authorization status
extension MapViewVC: MKMapViewDelegate, CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    LocationHandler.shared.setupUserLocationAtBest(onto: mapView, byMeters: aroundUserLocation, vc: self)
  }
}

//MARK: - Method to display the directions line as a custom color
extension MapViewVC {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
    renderer.strokeColor = .mainBlue
    return renderer
  }
}
