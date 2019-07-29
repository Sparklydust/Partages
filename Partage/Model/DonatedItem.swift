//
//  DonatedItem.swift
//  Partage
//
//  Created by Roland Lariotte on 17/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

final class DonatedItem: Codable {
  static let type: [DonorItemType] = [
    .selectItem,
    .food,
    .clothes,
    .hygiene,
    .other
  ]
  
  var id: Int?
  var isPicked: Bool
  var selectedType: String
  var name: String
  var pickUpDateTime: String
  var description: String
  var latitude: Double
  var longitude: Double
  var receiverID: String?
  
  init(isPicked: Bool, selectedType: String, name: String, pickUpDateTime: String, description: String, latitude: Double, longitude: Double, receiverID: String? = String()) {
    self.isPicked = isPicked
    self.selectedType = selectedType
    self.name = name
    self.pickUpDateTime = pickUpDateTime
    self.description = description
    self.latitude = latitude
    self.longitude = longitude
    self.receiverID = receiverID
  }
}
