//
//  ActionSheetLabel.swift
//  Partage
//
//  Created by Roland Lariotte on 08/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - UIAlert action sheet title
enum ActionSheetLabel: String {
  case camera
  case photoLibrary
  case cancel

  var description: String {
    get {
      switch(self) {
      case .camera:
        return LocalizableStrings.camera
      case .photoLibrary:
        return LocalizableStrings.photoLibrary
      case .cancel:
        return LocalizableStrings.cancel
      }
    }
  }
}
