//
//  Keys.swift
//  Partage
//
//  Created by Roland Lariotte on 18/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Keys for User Defaults, picker text color
enum Key: String {
  case pickerTextColor
  case partageUserToken
  case partageUserID
  case partageDeviceToken
  case partageActionCount

  var description: String {
    get {
      switch(self) {
      case .pickerTextColor:
        return LocalizableStrings.pickerTextColor
      case .partageUserToken:
        return LocalizableStrings.partageUserToken
      case .partageUserID:
        return LocalizableStrings.partageUserID
      case .partageDeviceToken:
        return LocalizableStrings.partageDeviceToken
      case .partageActionCount:
        return LocalizableStrings.partageActionCount
      }
    }
  }
}
