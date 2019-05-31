//
//  UIFont.swift
//  Partage
//
//  Created by Roland Lariotte on 30/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

enum CustomFont: String {
  case mainAppFont = "SuperclarendonRg-Bold"
  case buttonFont = "Arial-Black"
  case editLabelFont = "Arial-BoldMT"
  case disconnectLabelFont = "Georgia-Bold"
}

enum FontSize: CGFloat {
  case mainSize = 20
  case editLabelSize = 15
  case staticLabelSize = 14
  case disconnectLabelSize = 13
}

extension UIFont {
  convenience init?(customFont: CustomFont, withSize size: FontSize) {
    self.init(name: customFont.rawValue, size: size.rawValue)
  }
}
