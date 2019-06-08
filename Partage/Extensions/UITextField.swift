//
// UITextField.swift
//  Partage
//
//  Created by Roland Lariotte on 07/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Setup placeholder color and font style
extension UITextField {
  func setupPlaceholderDesign(title: StaticLabel, color: UIColor) {
    self.attributedPlaceholder = NSAttributedString(
      string: title.rawValue,
      attributes: [
        NSAttributedString.Key.foregroundColor: color,
        NSAttributedString.Key.font: UIFont(
          customFont: CustomFont.arial, withSize: FontSize.fifteen)!])
  }
}
