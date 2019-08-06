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
  
  var token: String? {
    get {
      return settingsContainer.token
    }
    set {
      settingsContainer.token = newValue
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
}
