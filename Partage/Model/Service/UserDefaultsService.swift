//
//  UserDefaultsService.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: = UserDefaults service class
class UserDefaultsService {
  static let shared = UserDefaultsService()
  private var settingsContainer: SettingsContainer

  init(settingsContainer: SettingsContainer = UserDefaultsContainer()) {
    self.settingsContainer = settingsContainer
  }
}

//MARK: - All variables to be used to access User Defaults
extension UserDefaultsService {
  var userToken: String? {
    get {
      return settingsContainer.userToken
    }
    set {
      settingsContainer.userToken = newValue
    }
  }
  
  var deviceToken: String? {
    get {
      return settingsContainer.deviceToken
    }
    set {
      settingsContainer.deviceToken = newValue
    }
  }

  var userID: String? {
    get {
      return settingsContainer.userID
    }
    set {
      settingsContainer.userID = newValue
    }
  }
  
  var actionCount: Int? {
    get {
      return settingsContainer.actionCount
    }
    set {
      settingsContainer.actionCount = newValue
    }
  }
  
  var appleID: String? {
    get {
      return settingsContainer.appleID
    }
    set {
      settingsContainer.appleID = newValue
    }
  }
  
  var signedInWithApple: Bool? {
    get {
      return settingsContainer.signedInWithApple
    }
    set {
      settingsContainer.signedInWithApple = newValue
    }
  }
}
