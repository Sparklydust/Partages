//
//  UILabel.swift
//  Partage
//
//  Created by Roland Lariotte on 13/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Setup UILbel font type, font size and font color
extension UILabel {
  func setupFont(as font: CustomFont, sized size: FontSize, in color: UIColor) {
    self.font = UIFont(customFont: font, withSize: size)
    self.textColor = color
  }
}

//MARK: - Dot button is selected design
extension UILabel {
  func isSelectedDesign() {
    self.text = "●"
    self.textColor = .mainBlue
    self.font = UIFont(customFont: .arialBold, withSize: .seventeen)
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.font = UIFont(customFont: .arialBold, withSize: .twentyFive)
      self.heightAnchor.constraint(equalToConstant: 36).isActive = true
      self.widthAnchor.constraint(equalToConstant: 36).isActive = true
    }
  }
}