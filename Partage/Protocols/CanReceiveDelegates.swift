//
//  CanReceiveDelegates.swift
//  Partage
//
//  Created by Roland Lariotte on 30/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - Protocol to send item address data from MapViewVC to DonatorVC
protocol CanReceiveItemAddressDelegate {
  func addressReceived(coordinates: CLLocation, streetNumber: String, streetName: String, postalCode: String, cityName: String, countryName: String)
}

//MARK: - Protocol to send images data from ItemImagesVC to DonatorVC
protocol CanReceiveItemImagesDelegate {
  func imagesReceived(image: [UIImage])
}

//MARK: - Protocol to send user auth data from SignInSignUpVC to SharingVC
protocol CanReceiveUserAuthDelegate {
  func userAuthReceived(_ firstName: String)
}