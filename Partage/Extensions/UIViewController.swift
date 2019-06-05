//
//  UIView.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK:- Corner Radius of only one side of UI elements
extension UIViewController {
  func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
    let path = UIBezierPath(
      roundedRect: view.bounds, byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    view.layer.mask = mask
  }
}
