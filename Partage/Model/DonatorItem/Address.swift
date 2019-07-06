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

////MARK: Initialization for when address comes back from DonatorItem in Firebase
//extension Address {
//  init?(_ dictionary: FirebaseDictionary) {
//    guard let latitude = dictionary[FirebaseKey.latitude.rawValue] as? Double,
//    let longitutde = dictionary[FirebaseKey.longitude.rawValue] as? Double,
//    let streetNumber = dictionary[FirebaseKey.streetNumber.rawValue] as? String,
//    let streetName = dictionary[FirebaseKey.streetName.rawValue] as? String,
//    let postalCode = dictionary[FirebaseKey.postalCode.rawValue] as? String,
//    let cityName = dictionary[FirebaseKey.cityName.rawValue] as? String,
//      let countryName = dictionary[FirebaseKey.countryName.rawValue] as? String else {
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
//
////MARK: - Method to save a dictionary structure to Firebase
//extension Address {
//  func toDictionary() -> FirebaseDictionary {
//    return [
//      FirebaseKey.latitude.rawValue: latitude,
//      FirebaseKey.longitude.rawValue: longitude,
//      FirebaseKey.streetNumber.rawValue: streetNumber,
//      FirebaseKey.streetName.rawValue: streetName,
//      FirebaseKey.postalCode.rawValue: postalCode,
//      FirebaseKey.cityName.rawValue: cityName,
//      FirebaseKey.countryName.rawValue: countryName
//    ]
//  }
//}
