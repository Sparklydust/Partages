//
//  Keys.swift
//  Partage
//
//  Created by Roland Lariotte on 18/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Keys for User Defaults and picker text color
enum Key: String {
  case pickerTextColor
  case partageTokenKey
  case partageUserID

  var description: String {
    get {
      switch(self) {
      case .pickerTextColor:
        return LocalizableStrings.pickerTextColor
      case .partageTokenKey:
        return LocalizableStrings.partageTokenKey
      case .partageUserID:
        return LocalizableStrings.partageUserID
      }
    }
  }
}
