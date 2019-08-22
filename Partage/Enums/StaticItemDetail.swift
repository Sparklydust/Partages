//
//  StaticItemDetailsLabels.swift
//  Partage
//
//  Created by Roland Lariotte on 08/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Static item detail name
enum StaticItemDetail: String {
  case giveDonation
  case receiveDonation
  case the
  case at
  case address
  case type
  case distanceInKm
  case distanceInM

  var description: String {
    get {
      switch(self) {
      case .giveDonation:
        return LocalizableStrings.giveDonation
      case .receiveDonation:
        return LocalizableStrings.receiveDonation
      case .the:
        return LocalizableStrings.the
      case .at:
        return LocalizableStrings.at
      case .address:
        return LocalizableStrings.address
      case .type:
        return LocalizableStrings.type
      case .distanceInKm:
        return LocalizableStrings.distanceInKm
      case .distanceInM:
        return LocalizableStrings.distanceInM
      }
    }
  }
}
