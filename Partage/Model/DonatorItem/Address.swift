//
//  Address.swift
//  Partage
//
//  Created by Roland Lariotte on 01/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

struct Address {
  var latitude: Double
  var longitude: Double
  var streetNumber: String
  var streetName: String
  var postalCode: String
  var cityName: String
  var countryName: String
  
  init(latitude: Double, longitude: Double, streetNumber: String, streetName: String, postalCode: String, city: String, country: String) {
    self.latitude = latitude
    self.longitude = longitude
    self.streetNumber = streetNumber
    self.streetName = streetName
    self.postalCode = postalCode
    self.cityName = city
    self.countryName = country
  }
}

////MARK: Initialization for when address comes back from DonatorItem database
//extension Address {
//  init?(_ dictionary: DatabaseDictionary) {
//    guard let latitude = dictionary[DatabaseKey.latitude.rawValue] as? Double,
//      let longitutde = dictionary[DatabaseKey.longitude.rawValue] as? Double,
//      let streetNumber = dictionary[DatabaseKey.streetNumber.rawValue] as? String,
//      let streetName = dictionary[DatabaseKey.streetName.rawValue] as? String,
//      let postalCode = dictionary[DatabaseKey.postalCode.rawValue] as? String,
//      let cityName = dictionary[DatabaseKey.cityName.rawValue] as? String,
//      let countryName = dictionary[DatabaseKey.countryName.rawValue] as? String else {
//        return nil
//    }
//    self.latitude = latitude
//    self.longitude = longitutde
//    self.streetNumber = streetNumber
//    self.streetName = streetName
//    self.postalCode = postalCode
//    self.cityName = cityName
//    self.countryName = countryName
//  }
//}
