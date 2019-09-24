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
    static let appleID = Key.appleID.description
    static let signedInWithApple = Key.signedInWithApple.description
  }
}

//MARK: - Conform to Protocol Settings Container to perform UserDefaults Service
extension UserDefaultsContainer: SettingsContainer {
  //MARK: Save or retrieve the user token
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
  
  //MARK: Save or retrieve the device token
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

  //MARK: Save or retrieve the user ID
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
  
  //MARK: Save or retrieve the user count actions before displaying App Store Review
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
  
  //MARK: Save or retrieve user apple ID
  var appleID: String? {
    get {
      UserDefaults.standard.string(
        forKey: Keys.appleID)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.appleID)
    }
  }
  
  //MARK: Save when user logged in using Signed in with Apple
  var signedInWithApple: Bool? {
    get {
      return UserDefaults.standard.bool(
        forKey: Keys.signedInWithApple)
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.signedInWithApple)
    }
  }
}
