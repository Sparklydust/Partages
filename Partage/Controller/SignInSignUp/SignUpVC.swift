//
//  SignUpVC.swift
//  Partage
//
//  Created by Roland Lariotte on 05/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var dotLabel: UILabel!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var registerActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var swipeGestureRecognizer: UISwipeGestureRecognizer!

  @IBOutlet var underlineViews: [UIView]!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    observeKeyboardNotification()
    triggerActivityIndicator(false)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Buttons actions
extension SignUpVC {
  //MARK: Register Button Action
  @IBAction func registerButtonAction(_ sender: Any) {
    createUserIntoDatabase()
  }
}

//MARK: - Main setup
extension SignUpVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupSignUpIsSelectedButtons()
    setupCancelButton()
    setupUnderlinesView()
    setupAllTextFields()
    setupAllPlaceholders()
    setupRegisterButton()
    setupDotLabel()
    setupSwipeGesture()
    setupPasswordAutoFill()
  }

  //MARK: Setup main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }

  //MARK: All delegates
  func setupAllDelegates() {
    firstNameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
  }
}

//MARK: - Design setup
extension SignUpVC {
  //MARK: Setup little sign up button design
  func setupSignUpIsSelectedButtons() {
    signInButton.signInOrSignUpUnselectedDesign(title: .lowSignIn)
    signUpButton.signInOrSignUpSelectedDesign(title: .lowSignUp)
    signInButton.isEnabled = true
    signUpButton.isEnabled = false
  }

  //MARK: Setup dot label design
  func setupDotLabel() {
    dotLabel.isSelectedDesign()
  }

  //MARK: Setup cancel button design
  func setupCancelButton() {
    cancelButton.commonDesign(title: .cancel)
  }

  //MARK: Setup sign up user register button design
  func setupRegisterButton() {
    registerButton.commonDesign(title: .signUp)
  }

  //MARK: Setup background text view design
  func setupUnderlinesView() {
    for underline in underlineViews {
      underline.setupBackgroundColorIn(.mainBlue)
    }
  }

  //MARK: Setup all text fields design
  func setupAllTextFields() {
    if let darkModeColor = UIColor.mainBlueIceWhiteDarkMode {
      firstNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
      emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
      passwordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
      confirmPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
    }
  }

  //MARK: Setup all placeholders design
  func setupAllPlaceholders() {
    firstNameTextField.setupPlaceholderDesign(title: .firsName, color: .middleBlue)
    emailTextField.setupPlaceholderDesign(title: .email, color: .middleBlue)
    passwordTextField.setupPlaceholderDesign(title: .password, color: .middleBlue)
    confirmPasswordTextField.setupPlaceholderDesign(title: .confirmPassword, color: .middleBlue)
  }
  
  //MARK: Setup email and password for auto fill
  func setupPasswordAutoFill() {
    emailTextField.textContentType = .username
    emailTextField.keyboardType = .emailAddress
    passwordTextField.textContentType = .newPassword
    confirmPasswordTextField.textContentType = .newPassword
  }
}

//MARK: - Setup tap gesture to dismiss keyboard
extension SignUpVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignAllResponder()
  }
}

//MARK: - Setup swipe gestures
extension SignUpVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .right {
      performSegue(withIdentifier: Segue.goToSignInVC.rawValue, sender: self)
    }
    if sender.direction == .down {
      guard firstNameTextField.isFirstResponder ||
        emailTextField.isFirstResponder ||
        passwordTextField.isFirstResponder ||
        confirmPasswordTextField.isFirstResponder else {
          unwindToSharingVC()
          return
      }
      view.endEditing(true)
    }
  }

  func setupSwipeGesture() {
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeRight.direction = .right
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeRight)
    view.addGestureRecognizer(swipeDown)
  }
}

//MARK: - Unwind to sharingVC
extension SignUpVC {
  func unwindToSharingVC() {
    performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
  }
}

//MARK: - Method to resign all responders
extension SignUpVC {
  func resignAllResponder() {
    firstNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
  }
}

//MARK: - Dismiss keyboard when done keyboard button is clicked
extension SignUpVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignAllResponder()
    return true
  }
}

//MARK: - Handle hidden text field on iPhone SE
extension SignUpVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(
      self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(
      self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    guard UIDevice.current.name ==
      DeviceName.iPhoneSE.description || UIDevice.current.name == DeviceName.iPhoneFiveS.description else { return }

    guard signInButton.isEnabled else { return }
    guard !signUpButton.isEnabled else { return }

    if confirmPasswordTextField.isEditing || passwordTextField.isEditing {
      if view.frame.origin.y == .zero {
        UIView.animate(withDuration: 0.4) {
          self.view.frame.origin.y -= (keyboardFrame.height / 3)
        }
      }
    }
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    if view.frame.origin.y != .zero {
      UIView.animate(withDuration: 0.4) {
        self.view.frame.origin.y = .zero
      }
    }
  }
}

//MARK: - Activity Indicator action and setup
extension SignUpVC {
  func triggerActivityIndicator(_ action: Bool) {
    guard action else {
      hideActivityIndicator()
      return
    }
    showActivityIndicator()
  }

  func showActivityIndicator() {
    registerActivityIndicator.isHidden = false
    registerActivityIndicator.style = UIActivityIndicatorView.Style.large
    registerActivityIndicator.color = .iceBackground
    view.addSubview(registerActivityIndicator)
    registerActivityIndicator.startAnimating()
    registerButton.commonDesign(title: .emptyString)
    registerButton.isHidden = false
    cancelButton.isEnabled = false
    signInButton.isEnabled = false
    swipeGestureRecognizer.isEnabled = false
  }

  func hideActivityIndicator() {
    registerActivityIndicator.isHidden = true
    registerButton.commonDesign(title: .signUp)
    cancelButton.isEnabled = true
    signInButton.isEnabled = true
    swipeGestureRecognizer.isEnabled = true
  }
}

//MARK: - API calls
extension SignUpVC {
  //MARK: User create an account in Database
  func createUserIntoDatabase() {
    guard let firstName = firstNameTextField.text,
      let email = emailTextField.text,
      let password = confirmPasswordTextField.text else { return }

    switch true {
    case firstName.isEmpty:
      showAlert(title: .firstNameErrorTitle, message: .addFirstName)
      break
    case email.isEmpty || !email.isValidEmail():
      showAlert(title: .emailErrorTitle, message: .addEmail)
      break
    case password.isEmpty || password != passwordTextField.text:
      showAlert(title: .passwordErrorTitle, message: .passwordDoesntMatch)
      break
    case password.count < 5:
      showAlert(title: .passwordErrorTitle, message: .passwordTooShort)
      break
    default:
      let user = CreateUser(firstName: firstName,
                            lastName: StaticLabel.emptyString.description,
                            email: email,
                            password: password
      )
      resignAllResponder()
      triggerActivityIndicator(true)

      let resourcePath = NetworkPath.users.description
      ResourceRequest<CreateUser>(resourcePath)
        .save(user, tokenNeeded: false) { [weak self] result in
        switch result {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: .errorTitle, message: .networkRequestError)
          }
        case .success:
          Auth().login(email: email, password: password, completion: { (result) in
            switch result {
            case .success:
              DispatchQueue.main.async { [weak self] in
                self?.performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
              }
            case .failure:
              DispatchQueue.main.async { [weak self] in
                self?.showAlert(title: .loginErrorTitle, message: .loginError)
              }
            }
          })
        }
      }
      triggerActivityIndicator(false)
    }
  }
}
