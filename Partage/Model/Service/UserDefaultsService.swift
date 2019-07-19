//
//  UserDefaultsService.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: = User defaults saver class
class UserDefaultsService {
  private struct Keys {
    static let token = Key.partageAPIKey.rawValue
    static let userID = Key.partageUserID.rawValue
  }
  
  //MARK: - Save or unsave the user token key
  static var token: String? {
    get {
      return UserDefaults.standard.string(
        forKey: Keys.token)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.token)
    }
  }
  
  static var userID: String? {
    get {
      return UserDefaults.standard.string(
        forKey: Keys.userID)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.userID)
    }
  }
}
