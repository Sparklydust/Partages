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
  
  @IBOutlet var underlineViews: [UIView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    observeKeyboardNotification()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Buttons actions
extension SignUpVC {
  //MARK: Register Button Action
  @IBAction func registerButtonAction(_ sender: Any) {
    
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

//MARK: - Setup little sign up button design
extension SignUpVC {
  func setupSignUpIsSelectedButtons() {
    signInButton.signInOrSignUpUnselectedDesign(title: .lowSignIn)
    signUpButton.signInOrSignUpSelectedDesign(title: .lowSignUp)
    signInButton.isEnabled = true
    signUpButton.isEnabled = false
  }
}

//MARK: - Setup dot label design
extension SignUpVC {
  func setupDotLabel() {
    dotLabel.isSelectedDesign()
  }
}

///MARK: - Setup cancel button design
extension SignUpVC {
  func setupCancelButton() {
    cancelButton.commonDesign(title: .cancel)
  }
}

//MARK: - Setup sign up user register button design
extension SignUpVC {
  func setupRegisterButton() {
    registerButton.commonDesign(title: .signUp)
  }
}

//MARK: - Setup background text view design
extension SignUpVC {
  func setupUnderlinesView() {
    for underline in underlineViews {
      underline.setupBackgroundColorIn(.mainBlue)
    }
  }
}

//MARK: - Setup all text fields design
extension SignUpVC {
  func setupAllTextFields() {
    firstNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    passwordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    confirmPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }
}

//MARK: - Setup all placeholders design
extension SignUpVC {
  func setupAllPlaceholders() {
    firstNameTextField.setupPlaceholderDesign(title: .firsName, color: .middleBlue)
    emailTextField.setupPlaceholderDesign(title: .email, color: .middleBlue)
    passwordTextField.setupPlaceholderDesign(title: .password, color: .middleBlue)
    confirmPasswordTextField.setupPlaceholderDesign(title: .confirmPassword, color: .middleBlue)
  }
}

//MARK: - Setup tap gesture to dismiss keyboard
extension SignUpVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignAllResponser()
  }
}

//MARK: - Setup swipe gestures
extension SignUpVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .right {
      performSegue(withIdentifier: Segue.goesToSignInVC.rawValue, sender: self)
    }
    if sender.direction == .down {
      guard firstNameTextField.isFirstResponder ||
        emailTextField.isFirstResponder ||
        passwordTextField.isFirstResponder ||
        confirmPasswordTextField.isFirstResponder else {
          performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: self)
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

//MARK: - Method to resign all responders
extension SignUpVC {
  func resignAllResponser() {
    firstNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
  }
}

//MARK: - Dismiss keyboard when done keyboard button is clicked
extension SignUpVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignAllResponser()
    return true
  }
}

//MARK: - Handle hidden text field on iPhone SE
extension SignUpVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    guard UIDevice.current.name == DeviceName.iPhoneSE.rawValue || UIDevice.current.name == DeviceName.iPhoneFiveS.rawValue else { return }
    
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
