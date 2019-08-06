//
//  UserDefaultsContainer.swift
//  Partage
//
//  Created by Roland Lariotte on 06/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - To hold UserDefaults computed porperties and keys
class UserDefaultsContainer {
  private struct Keys {
    static let token = Key.partageAPIKey.rawValue
    static let userID = Key.partageUserID.rawValue
  }
}

//MARK: - Conform to Protocol Settings Container to perform UserDefaults Service
extension UserDefaultsContainer: SettingsContainer {
  //MARK: - Save or retrieve the user token
  var token: String? {
    get {
      return UserDefaults.standard.string(
        forKey: Keys.token)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.token)
    }
  }
  
  //MARK: - Save or retrieve the user ID
  var userID: String? {
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
