//
//  CanReceiveProtocols.swift
//  Partage
//
//  Created by Roland Lariotte on 30/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - Protocol to send data from MapViewVC to DonatorVC
protocol CanReceiveItemAddress {
  func addressReceived(coordinates: CLLocation, streetNumber: String, streetName: String, postalCode: String, cityName: String, countryName: String)
}

//MARK: - Protocol to send data from ItemImagesVC to DonatorVC
protocol CanReceiveItemImages {
  func imagesReceived(image: [UIImage])
}
