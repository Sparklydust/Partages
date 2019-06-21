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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    LocationHandler.shared.setupUserLocationAtBest(onto: mapView, byMeters: aroundUserLocation, vc: self)
  }
}

//MARK: - Save location button action
extension MapViewVC {
  @IBAction func saveLocationButtonAction(_ sender: Any) {
    LocationHandler.shared.convertLatLonToAnAdress(vc: self)
  }
}

//MARK: - Long press gesture recognizer add pin with a vibration
extension MapViewVC {
  @IBAction func addPinLongPressGesture(_ sender: UILongPressGestureRecognizer) {
    LocationHandler.shared.userPinAndGetCoordinates(of: .meetingPoint, on: mapView, sender: sender)
    generator.impactOccurred()
  }
}

//MARK: - Setup main developer design
extension MapViewVC {
  func setupMainDesign() {
    setupMainView()
    setupNavigationController()
    setupSaveLocationButton()
  }
}

//MARK: - Setup main view design
extension MapViewVC {
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Setup navigation controller design
extension MapViewVC {
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup all delegates
extension MapViewVC: MKMapViewDelegate, CLLocationManagerDelegate {
  func setupAllDelegates() {
    mapView.delegate = self
    locationManager.delegate = self
  }
}

//MARK: - Setup save place button design
extension MapViewVC {
  func setupSaveLocationButton() {
    saveLocationButton.commonDesign(title: .saveMeetingPoint)
  }
}
