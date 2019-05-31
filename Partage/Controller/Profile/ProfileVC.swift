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
  @IBOutlet weak var firstNameView: UIView!
  @IBOutlet weak var passwordView: UIView!
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet var staticsLabel: [UILabel]!
  @IBOutlet var editButtonsLabel: [UIButton]!
  @IBOutlet var disconectionButtonsLabel: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupProfileImage()
    setupSpecificCornerRadius()
    setupFonts()
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

//MARK: - Set up profile image
extension ProfileVC {
  func setupProfileImage() {
    profileImage.image = #imageLiteral(resourceName: "noPicture")
    profileImage.roundedImage()
  }
}

//MARK: - Add specific corner radius on two corners
extension ProfileVC {
  func setupSpecificCornerRadius() {
    roundCorners(view: firstNameView, corners: .topRight, radius: 20)
    roundCorners(view: passwordView, corners: .bottomRight, radius: 20)
  }
}

//MARK: - Setup all fonts in View Controller
extension ProfileVC {
  func setupFonts() {
    userInfoFont()
    staticLabelFont()
    editButtonFont()
    disconnectButtonFont()
  }
  
  func userInfoFont() {
    firstNameLabel.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    lastNameLabel.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    emailLabel.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    passwordLabel.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
  }
  
  func staticLabelFont() {
    for label in staticsLabel {
      label.font = UIFont(customFont: .editLabelFont, withSize: .staticLabelSize)
    }
  }
  
  func editButtonFont() {
    for label in editButtonsLabel {
      label.titleLabel?.font = UIFont(customFont: .editLabelFont, withSize: .editLabelSize)
    }
  }
  
  func disconnectButtonFont() {
    for label in disconectionButtonsLabel {
      label.titleLabel?.font = UIFont(customFont: .disconnectLabelFont, withSize: .disconnectLabelSize)
    }
  }
}
