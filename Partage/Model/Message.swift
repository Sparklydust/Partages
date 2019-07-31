//
//  Message.swift
//  Partage
//
//  Created by Roland Lariotte on 17/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

final class Message: Codable {
  var id: Int?
  var itemID: Int
  var isReadByDonor: Bool
  var isReadByReceiver: Bool
  var sendDateTime: [Date]
  var body: [String]
  var donorID: String?
  var receiverID: String?
  
  init(itemID: Int, isReadByDonor: Bool, isReadByReceiver: Bool, sendDateTime: [Date], body: [String], donorID: String? = String(), receiverID: String = String()) {
    self.itemID = itemID
    self.isReadByDonor = isReadByDonor
    self.isReadByReceiver = isReadByReceiver
    self.sendDateTime = sendDateTime
    self.body = body
    self.donorID = donorID
    self.receiverID = receiverID
  }
}
