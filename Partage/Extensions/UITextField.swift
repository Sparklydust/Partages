//
// UITextField.swift
//  Partage
//
//  Created by Roland Lariotte on 07/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Setup  text field font type, font size and font color
extension UITextField {
  func setupFont(as font: CustomFont, sized size: FontSize, in color: UIColor) {
    self.font = UIFont(customFont: font, withSize: size)
    self.textColor = color
    self.tintColor = color
    
    //Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.font = UIFont(customFont: font, withSize: .thirtyTwo)
    }
  }
}

//MARK: - Setup placeholder color and font style
extension UITextField {
  func setupPlaceholderDesign(title: StaticLabel, color: UIColor) {
    self.attributedPlaceholder = NSAttributedString(
      string: title.rawValue,
      attributes: [
        NSAttributedString.Key.foregroundColor: color,
        NSAttributedString.Key.font: UIFont(
          customFont: .arial, withSize: .fifteen)!])
    
    //Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.attributedPlaceholder = NSAttributedString(
        string: title.rawValue,
        attributes: [
          NSAttributedString.Key.foregroundColor: color,
          NSAttributedString.Key.font: UIFont(
            customFont: .arial, withSize: .twentyTwo)!])
    }
  }
}
