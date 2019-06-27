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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
  }
}

//MARK: - Buttons actions
extension MapViewVC {
  //MARK: Save location button action
  @IBAction func saveLocationButtonAction(_ sender: Any) {
    LocationHandler.shared.convertLatLonToAnAdress(vc: self)
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

//MARK: - User change authorization status
extension MapViewVC: MKMapViewDelegate, CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    LocationHandler.shared.setupUserLocationAtBest(onto: mapView, byMeters: aroundUserLocation, vc: self)
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
    saveLocationButton.commonDesign(title: .saveMeetingPoint)
  }
}
