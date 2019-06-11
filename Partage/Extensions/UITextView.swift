//
//  UITextView.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Setup placeholder color font style
extension UITextView {
  func setupPlaceholderDesign(placeholderText: StaticLabel) {
    self.backgroundColor = UIColor.iceBackground
    self.textColor = UIColor.middleBlue
    self.text = placeholderText.rawValue
    self.font = UIFont(customFont: .arial, withSize: .fifteen)
  }
}
