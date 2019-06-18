//
//  UINavigationController.swift
//  Partage
//
//  Created by Roland Lariotte on 18/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Method to hide navigation controller
extension UINavigationController {
  func hideNavigationControllerBorder() {
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.tintColor = .iceBackground
  }
}
