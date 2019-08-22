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
  @IBOutlet weak var editProfileButton: UIBarButtonItem!
  @IBOutlet weak var editProfilePictureButton: UIButton!
  @IBOutlet weak var contactUsButton: UIButton!
  @IBOutlet weak var disconnectProfileButton: UIButton!
  @IBOutlet weak var deleteProfileButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet var backgroundViews: [UIView]!

  var user: FullUser? {
    didSet {
      updateUserProfile()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    triggerActivityIndicator(false)
    checkIfAnUserIsConnected()
    fetchUserFromTheDatabase()
  }
}

//MARK: - Buttons actions
extension ProfileVC {
  //MARK: Edit profile button action
  @IBAction func editProfileButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToEditProfile.rawValue, sender: self)
  }

  //MARK: Edit profile picture button action
  @IBAction func editProfilePictureButtonAction(_ sender: Any) {
    CameraHandler.shared.goesToUserLibraryOrCamera(vc: self)
    CameraHandler.shared.imagePickedBlock = {
      (image) in
      self.profileImage.image = image
      FirebaseStorageHandler.shared.upload(image, of: self.user!)
    }
  }

  //MARK: Contact Us button action
  @IBAction func contactUsButtonAction(_ sender: Any) {
    sendEmail()
  }

  //MARK: Disconnect profile button action
  @IBAction func disconnectProfileButtonAction(_ sender: Any) {
    deleteUserFromUserDefaults()
    deleteAllLabels()
    allTabsToTheirFirstController()
    setupProfileImage()
    performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
  }

  //MARK: Delete profile button action
  @IBAction func deleteProfileButtonAction(_ sender: Any) {
    deleteUserFromTheDatabase()
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
    setupProfileImage()
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
    FirebaseStorageHandler.shared.downloadProfilePicture(into: profileImage)
  }
}

//MARK: - Setup main labels design
extension ProfileVC {
  func setupMainLabels() {
    firstNameLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    emailLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    firstNameLabel.textAlignment = .center
    emailLabel.textAlignment = .center
  }
}

//MARK: - Setup edit button design
extension ProfileVC {
  func setupEditProfilePictureButton() {
    editProfilePictureButton.signInSignUpDesign(title: ButtonName.edit.description)
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

//MARK: - Activity Indicator action and setup
extension ProfileVC {
  func triggerActivityIndicator(_ action: Bool) {
    guard action else {
      hideActivityIndicator()
      return
    }
    showActivityIndicator()
  }

  func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.style = .whiteLarge
    activityIndicator.color = .mainBlue
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    disableButtons()
  }

  func hideActivityIndicator() {
    activityIndicator.isHidden = true
    enableButtons()
  }

  func disableButtons() {
    editProfilePictureButton.isEnabled = false
    editProfileButton.isEnabled = false
    deleteProfileButton.isEnabled = false
  }

  func enableButtons() {
    editProfilePictureButton.isEnabled = true
    editProfileButton.isEnabled = true
    deleteProfileButton.isEnabled = true
  }
}

//MARK: - Open mail app to contact us
extension ProfileVC: MFMailComposeViewControllerDelegate {
  func sendEmail() {
    guard MFMailComposeViewController.canSendMail() else {
      showAlert(title: .contactUsTitle, message: .contactUs)
      return
    }
    let mail = MFMailComposeViewController()
    mail.mailComposeDelegate = self
    mail.setToRecipients([ContactUs.partageEmail.description])
    mail.setSubject(ContactUs.subject.description)
    mail.setMessageBody(ContactUs.messageBody.description, isHTML: true)
    
    present(mail, animated: true)
  }

  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    if let _ = error {
      controller.dismiss(animated: true)
    }
    controller.dismiss(animated: true)
    switch result {
    case .cancelled:
      showAlert(title: .contactUsCanceledTitle, message: .contactUsCanceled)
    case .failed:
      showAlert(title: .contactUsFailedTitle, message: .contactUsFailed)
    case .saved:
      showAlert(title: .contactUsSavedTitle, message: .contactUsSaved)
    case .sent:
      showAlert(title: .contactUsSentTitle, message: .contactUsSent)
    @unknown default:
      fatalError()
    }
  }
}

//MARK: - Check if an user is connected, else send him to SignInVC
extension ProfileVC {
  func checkIfAnUserIsConnected() {
    guard UserDefaultsService.shared.token != nil else {
      showAlert(title: .restrictedTitle, message: .notConnected) { (true) in
        self.performSegue(withIdentifier: Segue.goToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
  }
}

//MARK: - Fetch user from the database
extension ProfileVC {
  func fetchUserFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    triggerActivityIndicator(true)

    let resourcePath = NetworkPath.myAccount.description + UserDefaultsService.shared.userID!
    ResourceRequest<FullUser>(resourcePath).get(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.triggerActivityIndicator(false)
            self?.showAlert(title: .errorTitle, message: .loginError)
        }
      case .success(let fullUser):
        DispatchQueue.main.async { [weak self] in
          self?.user = fullUser
          self?.triggerActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Delete user account method in cascade
extension ProfileVC {
  func deleteUserFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    showAlert(title: .userDeletedTitle, message: .userDeleted, buttonName: .confirm) { (true) in
      self.triggerActivityIndicator(true)
      let resourcePath = NetworkPath.deleteUser.description + UserDefaultsService.shared.userID!
      ResourceRequest<User>(resourcePath).delete(tokenNeeded: true, { (result) in
        switch result {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.triggerActivityIndicator(false)
            self?.showAlert(title: .errorTitle, message: .networkRequestError)
          }
        case .success:
          DispatchQueue.main.async { [weak self] in
            FirebaseStorageHandler.shared.deleteProfilePicture()
            self?.deleteAllLabels()
            self?.deleteUserFromUserDefaults()
            self?.setupProfileImage()
            self?.allTabsToTheirFirstController()
            self?.triggerActivityIndicator(false)
            self?.performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
          }
        }
      })
    }
  }
}

//MARK: - Delete user inside user defaults
extension ProfileVC {
  func deleteUserFromUserDefaults() {
    UserDefaultsService.shared.token = nil
    UserDefaultsService.shared.userID = nil
  }
}

//MARK: - Delete all labels when user disconnect
extension ProfileVC {
  func deleteAllLabels() {
    firstNameLabel.text = nil
    emailLabel.text = nil
  }
}

//MARK: - Update User profile after being connected
extension ProfileVC {
  func updateUserProfile() {
    if let firstName = user?.firstName, let lastName = user?.lastName {
      firstNameLabel.text = "\(firstName) \(lastName)"
    }
    emailLabel.text = user?.email
  }
}

//MARK: - Prepare for segue
extension ProfileVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goToEditProfile.rawValue {
      let destinationVC = segue.destination as! EditProfileVC
      destinationVC.user = user
    }
  }
}

//MARK: - Put all tabs to their origin controller when user disconnect or delete his profile
extension ProfileVC {
  func allTabsToTheirFirstController() {
    for viewController in tabBarController?.viewControllers ?? [] {
      if let vc = viewController as? UINavigationController {
        vc.popViewController(animated: true)
      }
    }
  }
}
