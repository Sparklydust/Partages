//
//  DonorItemType.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Donator item type to be chosen on DonationItem
enum DonorItemType: String {
  case selectItem
  case food
  case clothes
  case hygiene
  case other

  var description: String {
    get {
      switch(self) {
      case .selectItem:
        return LocalizableStrings.selectItem
      case .food:
        return LocalizableStrings.food
      case .clothes:
        return LocalizableStrings.clothes
      case .hygiene:
        return LocalizableStrings.hygiene
      case .other:
        return LocalizableStrings.other
      }
    }
  }
}
