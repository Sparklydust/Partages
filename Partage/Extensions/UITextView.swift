//
//  UITextView.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Setup  text view font type, font size and font color
extension UITextView {
  func setupFont(as font: CustomFont, sized size: FontSize, in color: UIColor) {
    self.font = UIFont(customFont: font, withSize: size)
    self.textColor = color
    self.tintColor = color

    //Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.font = UIFont(customFont: font, withSize: .twentyTwo)
    }
  }
}

//MARK: - Setup placeholder color font style
extension UITextView {
  func setupPlaceholderDesign(placeholderText: StaticLabel) {
    self.backgroundColor = UIColor.iceBackground
    self.textColor = UIColor.middleBlue
    self.text = placeholderText.description
    self.font = UIFont(customFont: .arial, withSize: .fifteen)

    //Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.font = UIFont(customFont: .arial, withSize: .twentyTwo)
    }
  }
}
