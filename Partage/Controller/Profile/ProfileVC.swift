//
//  ProfileVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MessageUI

class ProfileVC: UIViewController {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var editProfileButton: UIBarButtonItem!
  @IBOutlet weak var editProfilePictureButton: UIButton!
  @IBOutlet weak var contactUsButton: UIButton!
  @IBOutlet weak var disconnectProfileButton: UIButton!
  @IBOutlet weak var deleteProfileButton: UIButton!
  
  @IBOutlet var backgroundViews: [UIView]!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupProfileImage()
    
    firstNameLabel.text = "Roland"
    emailLabel.text = "roland.sound@live.fr"
    passwordLabel.text = "●●●●●●●●●●●●●●"
  }
}

//MARK: - Buttons actions
extension ProfileVC {
  //MARK: Edit profile button action
  @IBAction func editProfileButtonAction(_ sender: Any) {
  }
  
  //MARK: Edit profile picture button action
  @IBAction func editProfilePictureButtonAction(_ sender: Any) {
    CameraHandler.shared.goesToUserLibraryOrCamera(vc: self)
    CameraHandler.shared.imagePickedBlock = {
      (image) in
      self.profileImage.image = image
    }
  }
  
  //MARK: Contact Us button action
  @IBAction func contactUsButtonAction(_ sender: Any) {
    sendEmail()
  }
  
  //MARK: Disconnect profile button action
  @IBAction func disconnectProfileButtonAction(_ sender: Any) {
    UserDefaultsService.token = nil
    performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: self)
  }
  
  //MARK: Delete profile button action
  @IBAction func deleteProfileButtonAction(_ sender: Any) {
  }
}

//MARK: - Main setup
extension ProfileVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupMainLabels()
    setupEditProfilePictureButton()
    setupEditProfileButton()
    setupDisconnectButtons()
    setupNavigationController()
  }
  
  //MARK: Main view design
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
    contactUsButton.littleButtonDesign(title: .lowContactUs, color: .typoBlue)
    disconnectProfileButton.littleButtonDesign(title: .lowSignOut, color: .typoBlue)
    deleteProfileButton.littleButtonDesign(title: .lowEraseAccount, color: .red)
  }
}

//MARK: - Setup navigation controller design
extension ProfileVC {
  func setupNavigationController() {
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.tintColor = .typoBlue
    navigationController?.navigationBar.barTintColor = .iceBackground
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.hideNavigationControllerBorder()
  }
}

//MARK: - Open mail app to contact us
extension ProfileVC: MFMailComposeViewControllerDelegate {
  func sendEmail() {
    guard MFMailComposeViewController.canSendMail() else { return }
    let mail = MFMailComposeViewController()
    mail.mailComposeDelegate = self
    mail.setToRecipients([ContactUs.partageEmail.rawValue])
    mail.setSubject(ContactUs.subject.rawValue)
    mail.setMessageBody(ContactUs.messageBody.rawValue, isHTML: true)
    
    present(mail, animated: true)
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    if let _ = error {
      controller.dismiss(animated: true)
    }
    controller.dismiss(animated: true)
    switch result {
    case .cancelled:
      showAlert(title: .contactUsCanceled, message: .contactUsCanceled)
    case .failed:
      showAlert(title: .contactUsFailed, message: .contactUsFailed)
    case .saved:
      showAlert(title: .contactUsSaved, message: .contactUsSaved)
    case .sent:
      showAlert(title: .contactUsSent, message: .contactUsSent)
    @unknown default:
      fatalError()
    }
  }
}
