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
    static let userToken = Key.partageUserToken.description
    static let deviceToken = Key.partageDeviceToken.description
    static let userID = Key.partageUserID.description
    static let actionCount = Key.partageActionCount.description
  }
}

//MARK: - Conform to Protocol Settings Container to perform UserDefaults Service
extension UserDefaultsContainer: SettingsContainer {
  //MARK: - Save or retrieve the user token
  var userToken: String? {
    get {
      return UserDefaults.standard.string(
        forKey: Keys.userToken)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.userToken)
    }
  }
  
  //MARK: - Save or retrieve the device token
  var deviceToken: String? {
    get {
      return UserDefaults.standard.string(
        forKey: Keys.deviceToken)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.deviceToken)
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
  
  //MARK: - Save or retrieve the user count actions before displaying App Store Review
  var actionCount: Int? {
    get {
      return UserDefaults.standard.integer(
        forKey: Keys.actionCount)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.actionCount)
    }
  }
}
