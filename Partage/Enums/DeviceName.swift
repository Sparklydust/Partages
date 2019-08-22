//
//  DeviceName.swift
//  Partage
//
//  Created by Roland Lariotte on 19/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Apple devices name
enum DeviceName: String {
  case iPadFithGeneration
  case iPadSixthGeneration
  case iPadAir
  case iPadAirThirdGeneration
  case iPadAirTwo
  case iPadProNineSevenInch
  case iPadProTenFiveInch
  case iPadProElevenInch
  case iPadProTwelveNineInch
  case iPadProSecondGeneration
  case iPadProThirdGeneration
  case iPhoneFiveS
  case iPhoneSE

  var description: String {
    get {
      switch(self) {
      case .iPadFithGeneration:
        return LocalizableStrings.iPadFithGeneration
      case .iPadSixthGeneration:
        return LocalizableStrings.iPadSixthGeneration
      case .iPadAir:
        return LocalizableStrings.iPadAir
      case .iPadAirThirdGeneration:
        return LocalizableStrings.iPadAirThirdGeneration
      case .iPadAirTwo:
        return LocalizableStrings.iPadAirTwo
      case .iPadProNineSevenInch:
        return LocalizableStrings.iPadProNineSevenInch
      case .iPadProTenFiveInch:
        return LocalizableStrings.iPadProTenFiveInch
      case .iPadProElevenInch:
        return LocalizableStrings.iPadProElevenInch
      case .iPadProTwelveNineInch:
        return LocalizableStrings.iPadProTwelveNineInch
      case .iPadProSecondGeneration:
        return LocalizableStrings.iPadProSecondGeneration
      case .iPadProThirdGeneration:
        return LocalizableStrings.iPadProThirdGeneration
      case .iPhoneFiveS:
        return LocalizableStrings.iPhoneFiveS
      case .iPhoneSE:
        return LocalizableStrings.iPhoneSE
      }
    }
  }
}
