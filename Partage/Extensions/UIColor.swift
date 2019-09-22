//
//  UIColor.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - All the app colors grouped
extension UIColor {
  static let mainBlue = UIColor(
    red: 80/255.0, green: 150/255.0, blue: 242/255.0, alpha: 1)

  static let middleBlue = UIColor(
    red: 145/255.0, green: 187/255.0, blue: 242/255.0, alpha: 1)

  static let lightBlue = UIColor(
    red: 206/255.0, green: 222/255.0, blue: 242/255.0, alpha: 1)

  static let iceBackground = UIColor(
    red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
  
  static let typoBlue = UIColor(
    red: 17/255.0, green: 64/255.0, blue: 89/255.0, alpha: 1)

  static let typoBlueLight = UIColor(
    red: 56/255.0, green: 94/255.0, blue: 115/255.0, alpha: 1)
}

//MARK: - Color name for when using the dark mode
extension UIColor {
  static let iceBackgroundDarkMode = UIColor(
    named: Color.iceBackground.rawValue)
  
  static let mainBlueTypoBlueDarkMode = UIColor(
    named: Color.mainBlueTypoBlue.rawValue)
  
  static let mainBlueIceWhiteDarkMode = UIColor(
    named: Color.mainBlueIceWhite.rawValue)
  
  static let typoBlueLightDarkMode = UIColor(
    named: Color.typoBlueLight.rawValue)
  
  static let typoBlueMainBlueDarkMode = UIColor(
    named: Color.typoBlueMainBlue.rawValue)
  
  static let typoBlueGrayDarkMode = UIColor(
    named: Color.typoBlueGray.rawValue)
  
  static let typoBlueDarkMode = UIColor(
    named: Color.typoBlue.rawValue)
}
