//
//  DonatorItem.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

struct DonatorItem {
  static let type: [DonatorItemType] = [
    .selectItem,
    .food,
    .clothes,
    .hygiene,
    .other
  ]
  
//  var id: Int?
//  var donator: User
//  var receiver: User
  var selectedType: String
  var name: String
  var image: [UIImage]
  var pickUpDate: Date
  var address: Address
  var description: String
  
  init(selectedType: String, name: String, image: [UIImage], pickupDate: Date, address: Address, description: String) {
    self.selectedType = selectedType
    self.name = name
    self.image = image
    self.pickUpDate = pickupDate
    self.address = address
    self.description = description
  }
  
  //MARK: - Method to save a dictionary structure to Firebase
  func toDictionary() -> [String: Any] {
    return [
//      "id": id,
//      "donatorEmail": donator.email,
//      "donatorName": donator.firstName,
//      "receiverEmail": receiver.email,
//      "receiverName": receiver.firstName,
      FirebaseKey.type.rawValue: selectedType,
      FirebaseKey.name.rawValue: name,
      FirebaseKey.image.rawValue: image,
      FirebaseKey.pickUpDate.rawValue: pickUpDate,
      FirebaseKey.address.rawValue: address,
      FirebaseKey.description.rawValue: description
    ]
  }
}

//MARK: - Initializer for when items comes back from Firebase
extension DonatorItem {
  init?(dictionary: [String: Any]) {
    guard let selectedType = dictionary[FirebaseKey.type.rawValue] as? String,
    let name = dictionary[FirebaseKey.name.rawValue] as? String,
    let image = dictionary[FirebaseKey.image.rawValue] as? [UIImage],
    let pickUpDate = dictionary[FirebaseKey.pickUpDate.rawValue] as? Date,
    let address = dictionary[FirebaseKey.address.rawValue] as? Address,
      let description = dictionary[FirebaseKey.description.rawValue] as? String else {
        return nil
    }
    self.selectedType = selectedType
    self.name = name
    self.image = image
    self.pickUpDate = pickUpDate
    self.address = address
    self.description = description
  }
}
