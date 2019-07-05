//
//  DonatorItem.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

typealias FirebaseDictionary = [String: Any]

//MARK: - Donator Item Object
struct DonatorItem {
  static let type: [DonatorItemType] = [
    .selectItem,
    .food,
    .clothes,
    .hygiene,
    .other
  ]
  
//  var donator: User
//  var receiver: User?
  var selectedType: String
  var name: String
//  var image: [UIImage]
  var pickUpDate: String
  var latitude: Double
  var longitude: Double
  var description: String
  
  init(selectedType: String, name: String, /*image: [UIImage],*/ pickupDate: String, latitude: Double, longitude: Double, description: String) {
    self.selectedType = selectedType
    self.name = name
//    self.image = image
    self.pickUpDate = pickupDate
    self.latitude = latitude
    self.longitude = longitude
    self.description = description
  }
}

//MARK: - Initializer for when items comes back from Firebase
extension DonatorItem {
  init?(_ dictionary: FirebaseDictionary) {
    guard let selectedType = dictionary[FirebaseKey.type.rawValue] as? String,
      let name = dictionary[FirebaseKey.name.rawValue] as? String,
//      let image = dictionary[FirebaseKey.image.rawValue] as? [UIImage],
      let pickUpDate = dictionary[FirebaseKey.pickUpDate.rawValue] as? String,
      let latitude = dictionary[FirebaseKey.latitude.rawValue] as? Double,
      let longitude = dictionary[FirebaseKey.longitude.rawValue] as? Double,
      let description = dictionary[FirebaseKey.description.rawValue] as? String else {
        return nil
    }
    self.selectedType = selectedType
    self.name = name
//    self.image = image
    self.pickUpDate = pickUpDate
    self.latitude = latitude
    self.longitude = longitude
    self.description = description
  }
}

//MARK: - Method to save a dictionary structure to Firebase
extension DonatorItem {
  func toDictionary() -> FirebaseDictionary {
    return [
//      "donatorEmail": donator.email,
//      "donatorName": donator.firstName,
//      "receiverEmail": receiver.email?,
//      "receiverName": receiver.firstName?,
      FirebaseKey.type.rawValue: selectedType,
      FirebaseKey.name.rawValue: name,
//      FirebaseKey.image.rawValue: image,
      FirebaseKey.pickUpDate.rawValue: pickUpDate,
      FirebaseKey.longitude.rawValue: longitude,
      FirebaseKey.latitude.rawValue: latitude,
      FirebaseKey.description.rawValue: description
    ]
  }
}
