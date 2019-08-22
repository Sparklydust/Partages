//
//  Token.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Token class for PartageServerSide access
final class Token: Codable {
  var id: UUID?
  var token: String
  var userID: UUID

  init(token: String, userID: UUID) {
    self.token = token
    self.userID = userID
  }
}
