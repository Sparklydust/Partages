//
//  UIButton.swift
//  Partage
//
//  Created by Roland Lariotte on 05/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Opening display shre/receive button design
extension UIButton {
  func shareReceiveDesign(title: String, shadowOffsetHeight height: Int) {
    self.setTitle(title, for: .normal)
    self.setTitleColor(UIColor.iceBackground, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .mainAppFont, withSize: .shareButtonSize)
    self.backgroundColor = UIColor.mainBlue
    self.layer.cornerRadius = 20
    self.layer.shadowOffset = CGSize(width: 2, height: height)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 2
  }
}

//MARK: - Opening display sign in sign up button design
extension UIButton {
  func signInSignUpDesign(title: String) {
    self.setTitle(title, for: .normal)
    self.setTitleColor(UIColor.typoBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .editLabelFont, withSize: .editLabelSize)
  }
}
