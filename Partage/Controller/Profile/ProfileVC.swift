//
//  ProfileVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
  
  @IBOutlet weak var profileImage: UIImageView!
  
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var passwordLabel: UILabel!
  
  @IBOutlet var backgroundViews: [UIView]!
  @IBOutlet var staticsLabel: [UILabel]!
  @IBOutlet var editButtonsLabel: [UIButton]!
  @IBOutlet var disconectionButtonsLabel: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupProfileImage()
  }
}

//MARK: - Edit full profile button action
extension ProfileVC {
  @IBAction func editFullProfileButton(_ sender: Any) {
  }
}

//MARK: - Edit profile picture button action
extension ProfileVC {
  @IBAction func editProfilePictureButton(_ sender: Any) {
    CameraHandler.shared.showActionSheet(vc: self)
    CameraHandler.shared.imagePickedBlock = {
      (image) in
      self.profileImage.image = image
    }
  }
}

//MARK: - Disconnect profile button action
extension ProfileVC {
  @IBAction func disconnectProfileButton(_ sender: Any) {
  }
}

//MARK: - Delete profile button action
extension ProfileVC {
  @IBAction func deleteProfileButton(_ sender: Any) {
  }
}

//MARK: - Setup profile image
extension ProfileVC {
  func setupProfileImage() {
    profileImage.image = #imageLiteral(resourceName: "noPicture")
    profileImage.roundedImage()
  }
}

//MARK: - Setup all background views design
extension ProfileVC {
  func setupBackgroundViews() {
    for view in backgroundViews {
      view.backgroundColor = UIColor.mainBlue
      view.layer.cornerRadius = 10
    }
  }
}

//MARK: - Setup all user info design
extension ProfileVC {
  func setupUserInfo() {
    setupUserInfoFont()
    setupUserInfoTextColor()
  }
  
  func setupUserInfoFont() {
    firstNameLabel.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    lastNameLabel.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    emailLabel.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    passwordLabel.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
  }
  
  func setupUserInfoTextColor() {
    firstNameLabel.textColor = UIColor.iceBackground
    lastNameLabel.textColor = UIColor.iceBackground
    emailLabel.textColor = UIColor.iceBackground
    passwordLabel.textColor = UIColor.iceBackground
  }
}

//MARK: - Setup all static labels design
extension ProfileVC {
  func staticLabelFont() {
    for label in staticsLabel {
      label.font = UIFont(customFont: .arialBold, withSize: .fourteen)
      label.textColor = UIColor.typoBlue
    }
  }
  
  func setupStaticLabelName() {
    staticsLabel[0].text = StaticLabel.firsName.rawValue
    staticsLabel[1].text = StaticLabel.lastName.rawValue
    staticsLabel[2].text = StaticLabel.email.rawValue
    staticsLabel[3].text = StaticLabel.password.rawValue
    staticLabelFont()
  }
}

//MARK: - Setup edit button design
extension ProfileVC {
  func setupEditButtons() {
    for label in editButtonsLabel {
      label.titleLabel?.font = UIFont(customFont: .arialBold, withSize: .fifteen)
      label.tintColor = UIColor.typoBlue
      label.setTitle(ButtonName.edit.rawValue, for: .normal)
    }
  }
}

//MARK: - Setup disconnect and delete accound button
extension ProfileVC {
  func setupDisconnectButtons() {
    for label in disconectionButtonsLabel {
      label.titleLabel?.font = UIFont(customFont: .georgiaBold, withSize: .thirteen)
    }
    disconectionButtonsLabel[0].setTitle(ButtonName.lowSignOut.rawValue, for: .normal)
    disconectionButtonsLabel[0].tintColor = UIColor.typoBlue
    disconectionButtonsLabel[1].setTitle(ButtonName.lowEraseAccount.rawValue, for: .normal)
    disconectionButtonsLabel[1].tintColor = UIColor.mainRed
  }
}

//MARK: - Setup main developer design
extension ProfileVC {
  func setupMainDesign() {
    setupUserInfo()
    setupEditButtons()
    setupDisconnectButtons()
    setupStaticLabelName()
    setupBackgroundViews()
  }
}
