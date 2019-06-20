//
//  UIView.swift
//  Partage
//
//  Created by Roland Lariotte on 14/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Setup UIView main app background color
extension UIView {
  func setupMainBackgroundColor() {
    self.backgroundColor = .iceBackground
  }
}

//MARK: - Setup a custom background color
extension UIView {
  func setupBackgroundColorIn(_ color: UIColor) {
    self.backgroundColor = color
  }
}
