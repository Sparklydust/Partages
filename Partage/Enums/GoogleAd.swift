//
//  GoogleAd.swift
//  Partage
//
//  Created by Roland Lariotte on 25/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

enum GoogleAd {
  case unitID
  
  var description: String {
    get {
      switch (self) {
      case .unitID:
        return LocalizableStrings.unitID
      }
    }
  }
}
