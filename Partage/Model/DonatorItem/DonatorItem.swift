//
//  DonatorItem.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

typealias DatabaseDictionary = [String: Any]

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
  var image: [UIImage]
  var pickUpDate: String
  var latitude: Double
  var longitude: Double
  var description: String
  
  init(selectedType: String, name: String, image: [UIImage], pickupDate: String, latitude: Double, longitude: Double, description: String) {
    self.selectedType = selectedType
    self.name = name
    self.image = image
    self.pickUpDate = pickupDate
    self.latitude = latitude
    self.longitude = longitude
    self.description = description
  }
}

//MARK: - Initializer for when items comes back from database
extension DonatorItem {
  init?(_ dictionary: DatabaseDictionary) {
    guard let selectedType = dictionary[DatabaseKey.type.rawValue] as? String,
      let name = dictionary[DatabaseKey.name.rawValue] as? String,
      let image = dictionary[DatabaseKey.image.rawValue] as? [UIImage],
      let pickUpDate = dictionary[DatabaseKey.pickUpDate.rawValue] as? String,
      let latitude = dictionary[DatabaseKey.latitude.rawValue] as? Double,
      let longitude = dictionary[DatabaseKey.longitude.rawValue] as? Double,
      let description = dictionary[DatabaseKey.description.rawValue] as? String else {
        return nil
    }
    self.selectedType = selectedType
    self.name = name
    self.image = image
    self.pickUpDate = pickUpDate
    self.latitude = latitude
    self.longitude = longitude
    self.description = description
  }
}
