//
//  User.swift
//  Partage
//
//  Created by Roland Lariotte on 17/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

final class User: Codable {
  var id: UUID?
  var firstName: String
  
  init(firstName: String) {
    self.firstName = firstName
  }
}

final class CreateUser: Codable {
  var id: UUID?
  var firstName: String
  var lastName: String
  var email: String
  var password: String
  
  init(firstName: String, lastName: String, email: String, password: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
  }
}
