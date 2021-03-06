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
  @IBOutlet weak var newPasswordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet var spaceBetweenViewsConstraints: [NSLayoutConstraint]!
  @IBOutlet var underlineViews: [UIView]!

  var user: FullUser?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    //observeKeyboardNotification()
    populateUserInfo()
    triggerActivityIndicator(false)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Buttons actions
extension EditProfileVC {
  //MARK: Cancel Button action
  @IBAction func cancelButtonAction(_ sender: Any) {
    dismissView()
  }

  //MARK: Save Button action
  @IBAction func saveButtonAction(_ sender: Any) {
    updateUserInfo()
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
    setupPasswordAutoFill()
    setupIfUserLoggedInWithApple()
  }

  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Design setup
extension EditProfileVC {
  //MARK: Setup all underline views design
  func setupUnderlineViews() {
    for view in underlineViews {
      view.setupBackgroundColorIn(.mainBlue)
    }
  }

  //MARK: Setup all user entry text fields design
  func setupUserTextFields() {
    firstNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    lastNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    newPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    confirmPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }

  //MARK: Setup cancel and save buttons design
  func setupButtons() {
    cancelButton.commonDesign(title: .cancel)
    saveButton.commonDesign(title: .save)
  }

  //MARK: Setup placeholders design
  func setupTextFieldPlaceholders() {
    firstNameTextField.setupPlaceholderDesign(title: .firsName, color: .middleBlue)
    lastNameTextField.setupPlaceholderDesign(title: .lastName, color: .middleBlue)
    emailTextField.setupPlaceholderDesign(title: .email, color: .middleBlue)
    newPasswordTextField.setupPlaceholderDesign(title: .newPassword, color: .middleBlue)
    confirmPasswordTextField.setupPlaceholderDesign(title: .confirmPassword, color: .middleBlue)
  }

  //MARK: Setup to hide password modifcation text fields
  func hidePasswordFields() {
    newPasswordTextField.isHidden = true
    confirmPasswordTextField.isHidden = true
    underlineViews[3].isHidden = true
    underlineViews[4].isHidden = true
    underlineViews[5].isHidden = true
  }
  
  //MARK: Setup email and password for auto fill
  func setupPasswordAutoFill() {
    newPasswordTextField.textContentType = .newPassword
    confirmPasswordTextField.textContentType = .newPassword
  }
  
  //MARK: Setup to hide passwords field if user logged In with Apple
  func setupIfUserLoggedInWithApple() {
    let userLoggedInWithApple = UserDefaultsService.shared.signedInWithApple
    if let bool = userLoggedInWithApple {
      guard bool else {
        newPasswordTextField.isHidden = false
        confirmPasswordTextField.isHidden = false
        underlineViews[3].isHidden = false
        underlineViews[4].isHidden = false
        return
      }
      newPasswordTextField.isHidden = true
      confirmPasswordTextField.isHidden = true
      underlineViews[3].isHidden = true
      underlineViews[4].isHidden = true
    }
  }
}

//MARK: - Setup spaces between view on iPhoneSE
extension EditProfileVC {
  func setupViewsSpacingForUIDevices() {
    for constraint in spaceBetweenViewsConstraints {
      switch UIDevice.current.name {
      case DeviceName.iPhoneFiveS.description,
           DeviceName.iPhoneSE.description:
        constraint.constant = 60
      case DeviceName.iPadFithGeneration.description,
           DeviceName.iPadSixthGeneration.description,
           DeviceName.iPadAir.description,
           DeviceName.iPadAirThirdGeneration.description,
           DeviceName.iPadAirTwo.description,
           DeviceName.iPadProNineSevenInch.description,
           DeviceName.iPadProTenFiveInch.description:
        constraint.constant = 105
      case DeviceName.iPadProElevenInch.description,
           DeviceName.iPadProTwelveNineInch.description,
           DeviceName.iPadProSecondGeneration.description,
           DeviceName.iPadProThirdGeneration.description:
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

//MARK: - Dismiss view method
extension EditProfileVC {
  func dismissView() {
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - Populate user info from ProfileVC
extension EditProfileVC {
  func populateUserInfo() {
    firstNameTextField.text = user?.firstName
    lastNameTextField.text = user?.lastName
    emailTextField.text = user?.email
  }
}

//MARK: - All text field resign first responder method
extension EditProfileVC {
  func resignTextFieldResponders() {
    firstNameTextField.resignFirstResponder()
    lastNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
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

//MARK: - Activity Indicator action and setup
extension EditProfileVC {
  func triggerActivityIndicator(_ action: Bool) {
    guard action else {
      hideActivityIndicator()
      return
    }
    showActivityIndicator()
  }

  func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.color = .iceBackground
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    saveButton.commonDesign(title: .emptyString)
    saveButton.isHidden = false
  }

  func hideActivityIndicator() {
    activityIndicator.isHidden = true
    saveButton.commonDesign(title: .save)
  }
}

//MARK: - Handler to show hidden text field on iPhone SE
extension EditProfileVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(
      self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(
      self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize =
      notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    guard UIDevice.current.name ==
      DeviceName.iPhoneSE.description || UIDevice.current.name == DeviceName.iPhoneFiveS.description else { return }
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

//MARK: - User update his info with or without updading his password
extension EditProfileVC {
  func updateUserInfo() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let firstName = firstNameTextField.text,
      let lastName = lastNameTextField.text,
      let email = emailTextField.text,
    let newPassword = newPasswordTextField.text,
    let confirmPassword = confirmPasswordTextField.text else { return }

    if newPassword.isEmpty && confirmPassword.isEmpty {
      updateUserProfileWith(firstName, lastName, email)
    }
    else {
      updateUserProfileAndPasswordWith(firstName, lastName, email, confirmPassword)
    }
  }
}

//MARK: - API calls
extension EditProfileVC {
  //MARK: User update his profile without password
  func updateUserProfileWith(_ firstName: String, _ lastName: String, _ email: String) {
    let updatedUser = FullUser(
      firstName: firstName,
      lastName: lastName,
      email: email
    )
    let resourcePath = NetworkPath.editAccount.description + UserDefaultsService.shared.userID!

    checkIfEmptyFields(firstName, email) {
      ResourceRequest<FullUser>(resourcePath).update(updatedUser, tokenNeeded: true) { (success) in
        switch success {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: .errorTitle, message: .networkRequestError)
            self?.triggerActivityIndicator(false)
          }
        case .success(let user):
          DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.user = user
            self.dismissView()
            self.triggerActivityIndicator(false)
          }
        }
      }
    }
  }

  //MARK: User update his profile and password
  func updateUserProfileAndPasswordWith(_ firstName: String, _ lastName: String, _ email: String, _ password: String) {
    let updatedUser = FullUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password
    )
    let resourcePath = NetworkPath.editAccountAndPassord.description + UserDefaultsService.shared.userID!

    checkForEmptyFieldsAndPassword(firstName, email, password) {
      ResourceRequest<FullUser>(resourcePath).update(updatedUser, tokenNeeded: true) { (success) in
        switch success {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: .errorTitle, message: .networkRequestError)
            self?.triggerActivityIndicator(false)
          }
        case .success(let user):
          DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.user = user
            self.dismissView()
            self.triggerActivityIndicator(false)
          }
        }
      }
    }
  }
}

//MARK: - Switch to check if fields are is empty or not, password not included
extension EditProfileVC {
  func checkIfEmptyFields(_ firstName: String, _ email: String, _ completion: @escaping () -> ()) {
    switch true {
    case firstName.isEmpty:
      showAlert(title: .firstNameErrorTitle, message: .addFirstName)
      break
    case email.isEmpty || !email.isValidEmail():
      showAlert(title: .emailErrorTitle, message: .addEmail)
      break
    default:
      resignTextFieldResponders()
      triggerActivityIndicator(true)
      completion()
    }
  }
}

//MARK: - Switch to check if all fields included password are empty or not
extension EditProfileVC {
  func checkForEmptyFieldsAndPassword(_ firstName: String, _ email: String, _ password: String, completion: @escaping () -> ()) {
    switch true {
    case firstName.isEmpty:
      showAlert(title: .firstNameErrorTitle, message: .addFirstName)
      break
    case email.isEmpty || !email.isValidEmail():
      showAlert(title: .emailErrorTitle, message: .addEmail)
      break
    case password.isEmpty || password != newPasswordTextField.text:
      showAlert(title: .passwordErrorTitle, message: .passwordDoesntMatch)
      break
    case password.count < 5:
      showAlert(title: .passwordErrorTitle, message: .passwordTooShort)
      break
    default:
      resignTextFieldResponders()
      triggerActivityIndicator(true)
      completion()
    }
  }
}
