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

//MARK: - To have a border on a specific side of a UIView
extension UIView {
  func addBorder(atThe edge: UIRectEdge, in color: UIColor) {
    let border = CALayer()
    let thickness: CGFloat = 1
    border.backgroundColor = color.cgColor
    switch edge {
    case .top:
      border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
      break
    case .bottom:
      border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width - 40, height: thickness)
      break
    case .left:
      border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
      break
    case .right:
      border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
      break
    default: ()
    }
    layer.addSublayer(border)
  }
}
