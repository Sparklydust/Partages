//
//  Address.swift
//  Partage
//
//  Created by Roland Lariotte on 01/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

final class Address {
  var latitude: Double
  var longitude: Double
  var streetNumber: String
  var streetName: String
  var postalCode: String
  var cityName: String
  var countryName: String

  init(latitude: Double,
       longitude: Double,
       streetNumber: String,
       streetName: String,
       postalCode: String,
       city: String,
       country: String) {
    self.latitude = latitude
    self.longitude = longitude
    self.streetNumber = streetNumber
    self.streetName = streetName
    self.postalCode = postalCode
    self.cityName = city
    self.countryName = country
  }
}
