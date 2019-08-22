//
//  ChatMessage.swift
//  Partage
//
//  Created by Roland Lariotte on 06/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

final class ChatMessage: Codable {
  var id: Int?
  var user: String
  var date: String
  var content: String
  var messageID: Int

  init(user: String,
       date: String,
       content: String,
       messageID: Int) {
    self.user = user
    self.date = date
    self.content = content
    self.messageID = messageID
  }
}
