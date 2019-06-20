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
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var editProfileButton: UIBarButtonItem!
  @IBOutlet weak var editProfilePictureButton: UIButton!
  @IBOutlet weak var disconnectProfileButton: UIButton!
  @IBOutlet weak var deleteProfileButton: UIButton!
  
  @IBOutlet var backgroundViews: [UIView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupProfileImage()
    
    firstNameLabel.text = "Roland"
    emailLabel.text = "roland.sound@live.fr"
    passwordLabel.text = "●●●●●●●●●●●●●●"
  }
}

//MARK: - Edit profile button action
extension ProfileVC {
  @IBAction func editProfileButtonAction(_ sender: Any) {
  }
}

//MARK: - Edit profile picture button action
extension ProfileVC {
  @IBAction func editProfilePictureButtonAction(_ sender: Any) {
    CameraHandler.shared.goesToUserLibraryOrCamera(vc: self)
    CameraHandler.shared.imagePickedBlock = {
      (image) in
      self.profileImage.image = image
    }
  }
}

//MARK: - Disconnect profile button action
extension ProfileVC {
  @IBAction func disconnectProfileButtonAction(_ sender: Any) {
  }
}

//MARK: - Delete profile button action
extension ProfileVC {
  @IBAction func deleteProfileButtonAction(_ sender: Any) {
  }
}

//MARK: - Setup main developer design
extension ProfileVC {
  func setupMainDesign() {
    setupMainView()
    setupMainLabels()
    setupEditProfilePictureButton()
    setupEditProfileButton()
    setupDisconnectButtons()
    setupNavigationController()
  }
}

//MARK: - Setup main view design
extension ProfileVC {
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Setup profile image
extension ProfileVC {
  func setupProfileImage() {
    profileImage.image = #imageLiteral(resourceName: "noPicture")
    profileImage.rounded()
  }
}

//MARK: - Setup main labels design
extension ProfileVC {
  func setupMainLabels() {
    firstNameLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    emailLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    passwordLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    firstNameLabel.textAlignment = .center
    emailLabel.textAlignment = .center
    passwordLabel.textAlignment = .center
  }
}

//MARK: - Setup edit button design
extension ProfileVC {
  func setupEditProfilePictureButton() {
      editProfilePictureButton.signInSignUpDesign(title: .edit)
  }
}

//MARK: - Setup edit profile button
extension ProfileVC {
  func setupEditProfileButton() {
    editProfileButton.editButtonDesign()
  }
}

//MARK: - Setup disconnect and delete accound button
extension ProfileVC {
  func setupDisconnectButtons() {
    disconnectProfileButton.littleButtonDesign(title: .lowSignOut, color: .typoBlue)
    deleteProfileButton.littleButtonDesign(title: .lowEraseAccount, color: .red)
  }
}

//MARK: - Setup navigation controller design
extension ProfileVC {
  func setupNavigationController() {
    navigationController?.hideNavigationControllerBorder()
  }
}
