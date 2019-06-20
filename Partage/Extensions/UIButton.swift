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
  func shareReceiveDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(.iceBackground, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .superclarendonBold, withSize: .twentyTwo)
    self.backgroundColor = .mainBlue
    self.layer.cornerRadius = 20
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.titleLabel?.font = UIFont(customFont: .superclarendonBold, withSize: .thirtyTwo)
      self.heightAnchor.constraint(equalToConstant: 180).isActive = true
      self.widthAnchor.constraint(equalToConstant: 315).isActive = true
    }
  }
}

//MARK: - Opening display sign in sign up button design
extension UIButton {
  func signInSignUpDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(.typoBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .fifteen)
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .twentyTwo)
    }
  }
}

//MARK: - Common button action design
extension UIButton {
  func commonDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(.iceBackground, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .twenty)
    self.titleLabel?.adjustsFontSizeToFitWidth = true
    self.backgroundColor = .mainBlue
    self.layer.cornerRadius = 10
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.heightAnchor.constraint(equalToConstant: 60).isActive = true
      self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .thirty)
    }
  }
}

//MARK: - Sign in Sign up -> selected and unselected design
extension UIButton {
  func signInOrSignUpSelectedDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(.mainBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .seventeen)
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .twentyFive)
    }
  }
  
  func signInOrSignUpUnselectedDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(.typoBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .seventeen)
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .twentyFive)
    }
  }
}

//MARK: - Little button design
extension UIButton {
  func littleButtonDesign(title: ButtonName, color: UIColor) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(color, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .georgiaBold, withSize: .thirteen)
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.titleLabel?.font = UIFont(customFont: .georgiaBold, withSize: .twenty)
    }
  }
}

//MARK: - History and Favorite selected design
extension UIButton {
  func historyFavoriteSelectedDesign(named title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(.typoBlue, for: .normal)
    self.backgroundColor = .iceBackground
    self.layer.borderColor = UIColor.mainBlue.cgColor
    self.layer.borderWidth = 1
    self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .heighteen)
    self.isEnabled = false
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .thirty)
      self.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
  }
}

//MARK: - History and Favorite unselected design
extension UIButton {
  func historyFavoriteUnselectedDesign(named title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(.iceBackground, for: .normal)
    self.backgroundColor = .mainBlue
    self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .heighteen)
    self.isEnabled = true
    
    // Settings for iPad
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.titleLabel?.font = UIFont(customFont: .arialBlack, withSize: .thirty)
      self.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
  }
}
