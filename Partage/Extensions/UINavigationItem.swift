//
//  UINavigationItem.swift
//  Partage
//
//  Created by Roland Lariotte on 03/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Custom nav bar to set circle button in middle with profile image
extension UINavigationItem {
  func setupNavBarProfileImage() {
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
    button.setImage(#imageLiteral(resourceName: "noPicture"), for: .normal)
    button.imageView?.roundedImage()
    button.addTarget(self, action: #selector(clickedOnProfileImage), for: .touchUpInside)
    button.isEnabled = false
    self.titleView = button
  }
  
  // Action if button is enable and clicked on
  @objc func clickedOnProfileImage() { }
}
