//
//  Address.swift
//  Partage
//
//  Created by Roland Lariotte on 01/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import CoreLocation

struct Address {
  var coordinates: CLLocation
  var streetNumber: String
  var streetName: String
  var postalCode: String
  var cityName: String
  var countryName: String
  
  init(coordinates: CLLocation, streetNumber: String, streetName: String, postalCode: String, city: String, country: String) {
    self.coordinates = coordinates
    self.streetNumber = streetNumber
    self.streetName = streetName
    self.postalCode = postalCode
    self.cityName = city
    self.countryName = country
  }
}
