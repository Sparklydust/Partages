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
  var senderID: String
  var recipientID: String
  var date: String
  var isReadBySender: Bool
  var isReadByRecipient: Bool
  
  init(senderID: String, recipientID: String, date: String, isReadBySender: Bool, isReadByRecipient: Bool) {
    self.senderID = senderID
    self.recipientID = recipientID
    self.date = date
    self.isReadBySender = isReadBySender
    self.isReadByRecipient = isReadByRecipient
  }
}
