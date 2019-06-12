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
  let locationHandler = LocationHandler()
  
  let aroundUserLocation: CLLocationDistance = 500
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    locationHandler.setupUserLocationAtBest(onto: mapView, byMeters: aroundUserLocation, vc: self)
  }
}

//MARK: - Save location button action
extension MapViewVC {
  @IBAction func saveLocationButtonAction(_ sender: Any) {
  }
}

//MARK: - Setup main developer design
extension MapViewVC {
  func setupMainDesign() {
    navigationItem.setupNavBarProfileImage()
    setupSaveLocationButton()
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
    saveLocationButton.commonDesign(title: .saveMeetingPoint, shadowWidth: 0, shadowHeight: 2)
  }
}
