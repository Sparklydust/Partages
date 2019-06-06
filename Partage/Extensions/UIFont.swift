//
//  UIFont.swift
//  Partage
//
//  Created by Roland Lariotte on 30/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK:- Use to set custom font and size
extension UIFont {
  convenience init?(customFont: CustomFont, withSize size: FontSize) {
    self.init(name: customFont.rawValue, size: size.rawValue)
  }
}
