//
//  SignInSignUpVC.swift
//  Partage
//
//  Created by Roland Lariotte on 05/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SignInSignUpVC: UIViewController {
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  
  @IBOutlet weak var lostPasswordButton: UIButton!
  
  @IBOutlet var signInSignUpButtons: [UIButton]!
  @IBOutlet var dotLabels: [UILabel]!
  @IBOutlet var cancelAndRegisterButtons: [UIButton]!
  @IBOutlet var backgroundTextView: [UIView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextFieldDelegate()
    setupMainDesign()
    observeKeyboardNotification()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Change screen when sign in or sign up is selected
extension SignInSignUpVC {
  @IBAction func signInButtonAction(_ sender: Any) {
    UIView.animate(withDuration: 0.3) {
      self.setupSignInIsSelectedButtons()
      self.setupRegisterButtonWhenSignInIsSelected()
      self.hideTextFieldWhenSignInIsClicked()
      self.resignAllResponser()
      self.lostPasswordButton.isHidden = false
    }
  }
  
  @IBAction func signUpButtonAction(_ sender: Any) {
    UIView.animate(withDuration: 0.3) {
      self.setupSignUpIsSelectedButtons()
      self.setupRegisterButtonWhenSignUpIsSelected()
      self.showTextFieldWhenSignUpIsClicked()
      self.resignAllResponser()
      self.lostPasswordButton.isHidden = true
    }
  }
}

//MARK: - Cancel and Register buttons Actions
extension SignInSignUpVC {
  @IBAction func cancelButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func RegisterButtonAction(_ sender: Any) {
    
  }
}

//MARK: - Setup main VC design
extension SignInSignUpVC {
  func setupMainDesign() {
    setupSignInIsSelectedButtons()
    setupRegisterButtonWhenSignInIsSelected()
    setupCancelButton()
    setupLostPasswordButton()
    setupBackgroundTextView()
    setupAllTextFields()
    setupAllPlaceholders()
    hideTextFieldWhenSignInIsClicked()
  }
}

//MARK: - Set sign in / sign up buttons design
extension SignInSignUpVC {
  func setupSignInIsSelectedButtons() {
    signInSignUpButtons[0].signInSignUpSelectedDesign(title: .lowSignIn)
    signInSignUpButtons[1].signInSignUpUnselectedDesign(title: .lowSignUp)
    signInSignUpButtons[0].isEnabled = false
    signInSignUpButtons[1].isEnabled = true
    dotLabels[0].textColor = UIColor.mainBlue
    dotLabels[1].textColor = UIColor.typoBlue
  }
  
  func setupSignUpIsSelectedButtons() {
    signInSignUpButtons[0].signInSignUpUnselectedDesign(title: .lowSignIn)
    signInSignUpButtons[1].signInSignUpSelectedDesign(title: .lowSignUp)
    signInSignUpButtons[0].isEnabled = true
    signInSignUpButtons[1].isEnabled = false
    dotLabels[0].textColor = UIColor.typoBlue
    dotLabels[1].textColor = UIColor.mainBlue
  }
}

///MARK: - Set cancel and register buttons design
extension SignInSignUpVC {
  func setupCancelButton() {
    cancelAndRegisterButtons[0].commonDesign(title: .cancel, shadowWidth: 0, shadowHeight: -2)
  }
  
  func setupRegisterButtonWhenSignInIsSelected() {
    cancelAndRegisterButtons[1].commonDesign(title: .signIn, shadowWidth: 0, shadowHeight: 2)
  }
  
  func setupRegisterButtonWhenSignUpIsSelected() {
    cancelAndRegisterButtons[1].commonDesign(title: .signUp, shadowWidth: 0, shadowHeight: 2)
  }
}

//MARK: - Set lost password design
extension SignInSignUpVC {
  func setupLostPasswordButton() {
    lostPasswordButton.littleDesign(title: .lowLostPassword, color: .typoBlue)
  }
}

//MARK: - Set background text view design
extension SignInSignUpVC {
  func setupBackgroundTextView() {
    for view in backgroundTextView {
      view.backgroundColor = UIColor.mainBlue
      view.layer.cornerRadius = 10
    }
  }
}

//MARK: - Setup all text fields design
extension SignInSignUpVC {
  func setupAllTextFields() {
    firstNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .iceBackground)
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .iceBackground)
    passwordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .iceBackground)
    confirmPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .iceBackground)
  }
}

//MARK: - Hide / Show proper text field when sign in is clicked
extension SignInSignUpVC {
  func hideTextFieldWhenSignInIsClicked() {
    firstNameTextField.isHidden = true
    confirmPasswordTextField.isHidden = true
    backgroundTextView[0].isHidden = true
    backgroundTextView[3].isHidden = true
  }
  
  func showTextFieldWhenSignUpIsClicked() {
    firstNameTextField.isHidden = false
    confirmPasswordTextField.isHidden = false
    backgroundTextView[0].isHidden = false
    backgroundTextView[3].isHidden = false
  }
}

//MARK: - Setup all placeholders design
extension SignInSignUpVC {
  func setupAllPlaceholders() {
    firstNameTextField.setupPlaceholderDesign(title: .firsName, color: UIColor.iceBackground)
    emailTextField.setupPlaceholderDesign(title: .email, color: UIColor.iceBackground)
    passwordTextField.setupPlaceholderDesign(title: .password, color: UIColor.iceBackground)
    confirmPasswordTextField.setupPlaceholderDesign(title: .fullConfirmPassword, color: UIColor.iceBackground)
  }
}

//MARK: - Tap gesture dismiss keyboard
extension SignInSignUpVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignAllResponser()
  }
  
  func resignAllResponser() {
    firstNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
  }
}

extension SignInSignUpVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignAllResponser()
    return true
  }
  
  func setupTextFieldDelegate() {
    firstNameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
  }
}

//MARK: - Handle hidden text field on iPhone SE
extension SignInSignUpVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    guard UIDevice.current.name == "iPhone SE" else { return }
    
    guard signInSignUpButtons[0].isEnabled else { return }
    guard !signInSignUpButtons[1].isEnabled else { return }
    
    if confirmPasswordTextField.isEditing || passwordTextField.isEditing {
      if view.frame.origin.y == 0 {
        UIView.animate(withDuration: 0.4) {
          self.view.frame.origin.y -= (keyboardFrame.height / 3)
        }
      }
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    if view.frame.origin.y != 0 {
      UIView.animate(withDuration: 0.4) {
        self.view.frame.origin.y = 0
      }
    }
  }
}
