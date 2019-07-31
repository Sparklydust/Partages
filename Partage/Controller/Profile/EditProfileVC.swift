//
//  EditProfileVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var oldPasswordTextField: UITextField!
  @IBOutlet weak var newPasswordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBOutlet var spaceBetweenViewsConstraints: [NSLayoutConstraint]!
  @IBOutlet var underlineViews: [UIView]!
  
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    observeKeyboardNotification()
    hidePasswordFields()
    populateUserInfo()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Buttons actions
extension EditProfileVC {
  //MARK: Cancel Button action
  @IBAction func cancelButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  //MARK: Save Button action
  @IBAction func saveButtonAction(_ sender: Any) {
  }
}

//MARK: - Main setup
extension EditProfileVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupUnderlineViews()
    setupUserTextFields()
    setupButtons()
    setupTextFieldPlaceholders()
    setupSwipeGesture()
    setupViewsSpacingForUIDevices()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Setup all underline views design
extension EditProfileVC {
  func setupUnderlineViews() {
    for view in underlineViews {
      view.setupBackgroundColorIn(.mainBlue)
    }
  }
}

//MARK: - Setup all user entry text fields design
extension EditProfileVC{
  func setupUserTextFields() {
    firstNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    lastNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    oldPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    newPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    confirmPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }
}

//MARK: - Setup cancel and save buttons design
extension EditProfileVC {
  func setupButtons() {
    cancelButton.commonDesign(title: .cancel)
    saveButton.commonDesign(title: .save)
  }
}

//MARK: - Setup placeholders design
extension EditProfileVC {
  func setupTextFieldPlaceholders() {
    firstNameTextField.setupPlaceholderDesign(title: .firsName, color: .middleBlue)
    lastNameTextField.setupPlaceholderDesign(title: .lastName, color: .middleBlue)
    emailTextField.setupPlaceholderDesign(title: .email, color: .middleBlue)
    oldPasswordTextField.setupPlaceholderDesign(title: .oldPassword, color: .middleBlue)
    newPasswordTextField.setupPlaceholderDesign(title: .newPassword, color: .middleBlue)
    confirmPasswordTextField.setupPlaceholderDesign(title: .confirmPassword, color: .middleBlue)
  }
}

//MARK: - Setup to hide password modifcation text fields
extension EditProfileVC {
  func hidePasswordFields() {
    oldPasswordTextField.isHidden = true
    newPasswordTextField.isHidden = true
    confirmPasswordTextField.isHidden = true
    underlineViews[3].isHidden = true
    underlineViews[4].isHidden = true
    underlineViews[5].isHidden = true
  }
}

//MARK: - Setup spaces between view on iPhoneSE
extension EditProfileVC {
  func setupViewsSpacingForUIDevices() {
    for constraint in spaceBetweenViewsConstraints {
      switch UIDevice.current.name {
      case DeviceName.iPhoneFiveS.rawValue,
           DeviceName.iPhoneSE.rawValue:
        constraint.constant = 60
      case DeviceName.iPadFithGeneration.rawValue,
           DeviceName.iPadSixthGeneration.rawValue,
           DeviceName.iPadAir.rawValue,
           DeviceName.iPadAirThirdGeneration.rawValue,
           DeviceName.iPadAirTwo.rawValue,
           DeviceName.iPadProNineSevenInch.rawValue,
           DeviceName.iPadProTenFiveInch.rawValue:
        constraint.constant = 105
      case DeviceName.iPadProElevenInch.rawValue,
           DeviceName.iPadProTwelveNineInch.rawValue,
           DeviceName.iPadProSecondGeneration.rawValue,
           DeviceName.iPadProThirdGeneration.rawValue:
        constraint.constant = 140
      default: ()
      }
    }
  }
}

//MARK: - Setup tap gesture to dismiss keyboard
extension EditProfileVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignTextFieldResponders()
  }
}

//MARK: - Setup swipe gesture
extension EditProfileVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    guard firstNameTextField.isFirstResponder ||
      lastNameTextField.isFirstResponder ||
      emailTextField.isFirstResponder ||
      oldPasswordTextField.isFirstResponder ||
      newPasswordTextField.isFirstResponder ||
      confirmPasswordTextField.isFirstResponder else {
        dismiss(animated: true, completion: nil)
        return
    }
    view.endEditing(true)
  }
  
  func setupSwipeGesture() {
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeDown)
  }
}

//MARK: - Populate user info from ProfileVC
extension EditProfileVC {
  func populateUserInfo() {
    firstNameTextField.text = user?.firstName
  }
}

//MARK: - All text field resign first responder method
extension EditProfileVC {
  func resignTextFieldResponders() {
    firstNameTextField.resignFirstResponder()
    lastNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    oldPasswordTextField.resignFirstResponder()
    newPasswordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
  }
}

//MARK: - Dismiss keyboard when done button is clicked
extension EditProfileVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignTextFieldResponders()
    return true
  }
}

//MARK: - Handler to show hidden text field on iPhone SE
extension EditProfileVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    guard UIDevice.current.name == DeviceName.iPhoneSE.rawValue || UIDevice.current.name == DeviceName.iPhoneFiveS.rawValue else { return }
    guard confirmPasswordTextField.isEditing || newPasswordTextField.isEditing else { return }
    guard view.frame.origin.y == .zero else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y -= (keyboardFrame.height / 3)
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    guard view.frame.origin.y != .zero else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y = .zero
    }
  }
}

//extension EditProfileVC {
//  func updateUserProfile() {
//    let userToUpdate = User(firstName: <#T##String#>)
//    
//    UserRequest<User>(resourcePath: .users, userID: UserDefaultsService.userID!).update(with: userToUpdate) { (success) in
//      switch success {
//      case .failure:
//        DispatchQueue.main.async { [weak self] in
//          self?.showAlert(title: .error, message: .networkRequestError)
//        }
//      case .success(let updatesUser):
//        DispatchQueue.main.async { [weak self] in
//          
//        }
//      }
//    }
//  }
//}
