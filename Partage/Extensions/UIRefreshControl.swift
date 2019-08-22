//
//  UIRefreshControl.swift
//  Partage
//
//  Created by Roland Lariotte on 01/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Common design for refresh control
extension UIRefreshControl {
  func commonDesign(title: StaticLabel) {
    self.tintColor = .mainBlue
    let attr = [NSAttributedString.Key.foregroundColor: UIColor.typoBlue]
    self.attributedTitle = NSAttributedString(string: title.description, attributes: attr)
  }
}
