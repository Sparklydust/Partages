//
//  User.swift
//  Partage
//
//  Created by Roland Lariotte on 17/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import AuthenticationServices

//MARK: - Public user class
final class User: Codable {
  var id: UUID?
  var firstName: String

  init(firstName: String) {
    self.firstName = firstName
  }
}

//MARK: - Full user access class
final class FullUser: Codable {
  var id: UUID?
  var firstName: String
  var lastName: String
  var email: String
  var password: String?

  init(firstName: String,
       lastName: String,
       email: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
  }

  init(firstName: String,
       lastName: String,
       email: String,
       password: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
  }
  
  init(credentials: ASAuthorizationAppleIDCredential) {
    let emptyString = StaticLabel.emptyString.description
    self.firstName = credentials.fullName?.givenName ?? emptyString
    self.lastName = credentials.fullName?.familyName ?? emptyString
    self.email = credentials.email ?? emptyString
  }
}

//MARK: - Use to create or update an user
final class CreateUser: Codable {
  var id: UUID?
  var firstName: String
  var lastName: String
  var email: String
  var password: String

  init(firstName: String,
       lastName: String,
       email: String,
       password: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
  }
}
