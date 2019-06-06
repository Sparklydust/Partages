//
//  UIBarButtonItem.swift
//  Partage
//
//  Created by Roland Lariotte on 06/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Edit button design
extension UIBarButtonItem {
  func editButtonDesign() {
    self.title = ButtonName.edit.rawValue
    self.setTitleTextAttributes(
      [NSAttributedString.Key.font: UIFont(
        customFont: .editLabelFont, withSize: .editLabelSize)!,
       NSAttributedString.Key.foregroundColor: UIColor.typoBlue],
      for: .normal)
  }
}
