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
  case mainAppFontLight = "SuperclarendonLt"
  case buttonFont = "Arial-Black"
  case editLabelFont = "Arial-BoldMT"
  case messageLabelFont = "ArialMT"
  case disconnectLabelFont = "Georgia-Bold"
}

enum FontSize: CGFloat {
  case mainSize = 20
  case nameLabelSize = 16
  case editLabelSize = 15
  case staticLabelSize = 14
  case disconnectLabelSize = 13
  case dateLabelSize = 12
  case smallDateLabelSize = 10
}

extension UIFont {
  convenience init?(customFont: CustomFont, withSize size: FontSize) {
    self.init(name: customFont.rawValue, size: size.rawValue)
  }
}
