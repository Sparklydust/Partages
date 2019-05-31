//
//  UIImageView.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

extension UIImageView {
  //MARK: - Round up a square image
  func roundedImage() {
    self.layer.cornerRadius = self.frame.size.width / 2
    self.clipsToBounds = true
  }
  
  //MARK: - Round up a square image with a main blue border
  func roundedImageWithMainBlueBorder() {
    self.layer.cornerRadius = self.frame.size.width / 2
    self.clipsToBounds = true
    self.layer.borderColor = UIColor.mainBlue.cgColor
    self.layer.borderWidth = 1.5
  }
  
  //MARK: - Round up a square image with a middle blue border
  func roundedImageWithMiddleBlueBorder() {
    self.layer.cornerRadius = self.frame.size.width / 2
    self.clipsToBounds = true
    self.layer.borderColor = UIColor.middleBlue.cgColor
    self.layer.borderWidth = 1.5
  }
  
  //MARK: - Round up a square image with a light blue border
  func roundedImageWithLightBlueBorder() {
    self.layer.cornerRadius = self.frame.size.width / 2
    self.clipsToBounds = true
    self.layer.borderColor = UIColor.lightBlue.cgColor
    self.layer.borderWidth = 1.5
  }
  
  //MARK: - Create a border around any view type
  func addOutlineBorder(sized width: CGFloat, in color: CGColor) {
    self.layer.borderWidth = width
    self.layer.borderColor = color
  }
}
