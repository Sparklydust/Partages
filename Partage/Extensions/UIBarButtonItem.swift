//
//  UIBarButtonItem.swift
//  Partage
//
//  Created by Roland Lariotte on 06/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Edit button design in navigation bar
extension UIBarButtonItem {
  func editButtonDesign() {
    self.title = ButtonName.edit.rawValue
    self.setTitleTextAttributes(
      [NSAttributedString.Key.font: UIFont(
        customFont: .arialBold, withSize: .fifteen)!,
       NSAttributedString.Key.foregroundColor: UIColor.typoBlue],
      for: .normal)
  }
}