//
//  UIButton.swift
//  Partage
//
//  Created by Roland Lariotte on 05/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Opening display share/receive button design
extension UIButton {
  func shareReceiveDesign(title: ButtonName, shadowHeight height: Int) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.iceBackground, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .superclarendonBold, withSize: .twentyTwo)
    self.backgroundColor = UIColor.mainBlue
    self.layer.cornerRadius = 20
    self.layer.shadowOffset = CGSize(width: 2, height: height)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 2
  }
}

//MARK: - Opening display sign in sign up button design
extension UIButton {
  func signInSignUpDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.typoBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .fifteen)
  }
}

//MARK: - Common button action design
extension UIButton {
  func commonDesign(title: ButtonName, shadowWidth width: Int, shadowHeight height: Int) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.lightBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .twenty)
    self.titleLabel?.adjustsFontSizeToFitWidth = true
    self.backgroundColor = UIColor.mainBlue
    self.layer.cornerRadius = 20
    self.layer.shadowOffset = CGSize(width: width, height: height)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 2
  }
}

//MARK: - Sign in Sign up -> selected and unselected design
extension UIButton {
  func signInSignUpSelectedDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.mainBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .seventeen)
  }
  
  func signInSignUpUnselectedDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.typoBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .seventeen)
  }
}

//MARK: - Little button design
extension UIButton {
  func littleDesign(title: ButtonName, color: UIColor) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(color, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .georgiaBold, withSize: .thirteen)
  }
}

//MARK: - History and Favorite selected design
extension UIButton {
  func historyFavoriteSelectedDesign(title: ButtonName, shadowWidth width: Int, shadowHeight height: Int) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.typoBlue, for: .normal)
    self.backgroundColor = UIColor.iceBackground
    self.layer.borderColor = UIColor.mainBlue.cgColor
    self.layer.borderWidth = 1
    self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .heighteen)
    self.layer.shadowOffset = CGSize(width: width, height: height)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 2
    self.isEnabled = false
  }
}

//MARK: - History and Favorite unselected design
extension UIButton {
  func historyFavoriteUnselectedDesign(title: ButtonName, shadowWidth width: Int, shadowHeight height: Int) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.lightBlue, for: .normal)
    self.backgroundColor = UIColor.mainBlue
    self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .heighteen)
    self.layer.shadowOffset = CGSize(width: width, height: height)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 2
    self.isEnabled = true
  }
}
