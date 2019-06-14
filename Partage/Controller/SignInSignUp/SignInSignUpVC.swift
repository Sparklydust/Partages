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
  
  @IBOutlet var dotStylebuttons: [UIButton]!
  @IBOutlet var cancelAndRegisterButtons: [UIButton]!
  
  @IBOutlet var backgroundTextView: [UIView]!
  
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

//MARK: - Register Button Action
extension SignInSignUpVC {
  @IBAction func RegisterButtonAction(_ sender: Any) {
    
  }
}

//MARK: - Change screen when sign in or sign up button action is selected
extension SignInSignUpVC {
  @IBAction func signInButtonAction(_ sender: Any) {
    UIView.animate(withDuration: 0.3) {
      self.signInIsSelectedStyle()
    }
  }
  
  @IBAction func signUpButtonAction(_ sender: Any) {
    UIView.animate(withDuration: 0.3) {
      self.signUpIsSelectedStyle()
    }
  }
}

//MARK: - Change screen when dot sign in or sign up button action is selected
extension SignInSignUpVC {
  @IBAction func dotSignInButtonAction(_ sender: Any) {
    UIView.animate(withDuration: 0.3) {
      self.signInIsSelectedStyle()
    }
  }
  
  @IBAction func dotSignUpButtonAction(_ sender: Any) {
    UIView.animate(withDuration: 0.3) {
      self.signUpIsSelectedStyle()
    }
  }
}

//MARK: - Cancel and Register buttons Actions
extension SignInSignUpVC {
  @IBAction func cancelButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
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
    hideTextFieldsWhenSignInIsClicked()
  }
}

//MARK: - Setup all delegates
extension SignInSignUpVC {
  func setupAllDelegates() {
    firstNameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
  }
}

//MARK: - Setup sign in / sign up buttons design
extension SignInSignUpVC {
  func setupSignInIsSelectedButtons() {
    signInSignUpButtons[0].signInOrSignUpSelectedDesign(title: .lowSignIn)
    signInSignUpButtons[1].signInOrSignUpUnselectedDesign(title: .lowSignUp)
    signInSignUpButtons[0].isEnabled = false
    signInSignUpButtons[1].isEnabled = true
    dotStylebuttons[0].setTitleColor(.mainBlue, for: .normal)
    dotStylebuttons[1].setTitleColor(.typoBlue, for: .normal)
    dotStylebuttons[0].isEnabled = false
    dotStylebuttons[1].isEnabled = true
  }
  
  func setupSignUpIsSelectedButtons() {
    signInSignUpButtons[0].signInOrSignUpUnselectedDesign(title: .lowSignIn)
    signInSignUpButtons[1].signInOrSignUpSelectedDesign(title: .lowSignUp)
    signInSignUpButtons[0].isEnabled = true
    signInSignUpButtons[1].isEnabled = false
    dotStylebuttons[0].setTitleColor(.typoBlue, for: .normal)
    dotStylebuttons[1].setTitleColor(.mainBlue, for: .normal)
    dotStylebuttons[0].isEnabled = true
    dotStylebuttons[1].isEnabled = false
  }
}

///MARK: - Setup cancel button design
extension SignInSignUpVC {
  func setupCancelButton() {
    cancelAndRegisterButtons[0].commonDesign(title: .cancel, shadowWidth: 0, shadowHeight: -2)
  }
}

//MARK: - Setup sign in or sign up button design
extension SignInSignUpVC {
  func setupRegisterButtonWhenSignInIsSelected() {
    cancelAndRegisterButtons[1].commonDesign(title: .signIn, shadowWidth: 0, shadowHeight: 2)
  }
  
  func setupRegisterButtonWhenSignUpIsSelected() {
    cancelAndRegisterButtons[1].commonDesign(title: .signUp, shadowWidth: 0, shadowHeight: 2)
  }
}

//MARK: - Setup lost password design
extension SignInSignUpVC {
  func setupLostPasswordButton() {
    lostPasswordButton.littleButtonDesign(title: .lowLostPassword, color: .typoBlue)
  }
}

//MARK: - Setup background text view design
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

//MARK: - Setup all placeholders design
extension SignInSignUpVC {
  func setupAllPlaceholders() {
    firstNameTextField.setupPlaceholderDesign(title: .firsName, color: UIColor.iceBackground)
    emailTextField.setupPlaceholderDesign(title: .email, color: UIColor.iceBackground)
    passwordTextField.setupPlaceholderDesign(title: .password, color: UIColor.iceBackground)
    confirmPasswordTextField.setupPlaceholderDesign(title: .fullConfirmPassword, color: UIColor.iceBackground)
  }
}

//MARK: - Hide / Show proper text field when sign in is clicked
extension SignInSignUpVC {
  func hideTextFieldsWhenSignInIsClicked() {
    firstNameTextField.isHidden = true
    confirmPasswordTextField.isHidden = true
    backgroundTextView[0].isHidden = true
    backgroundTextView[3].isHidden = true
  }
  
  func showTextFieldsWhenSignUpIsClicked() {
    firstNameTextField.isHidden = false
    confirmPasswordTextField.isHidden = false
    backgroundTextView[0].isHidden = false
    backgroundTextView[3].isHidden = false
  }
}

//MARK: - Setup sign in Selected style
extension SignInSignUpVC {
  func signInIsSelectedStyle() {
    setupSignInIsSelectedButtons()
    setupRegisterButtonWhenSignInIsSelected()
    hideTextFieldsWhenSignInIsClicked()
    resignAllResponser()
    lostPasswordButton.isHidden = false
  }
}

//MARK: - Setup sign up Selected style
extension SignInSignUpVC {
  func signUpIsSelectedStyle() {
    setupSignUpIsSelectedButtons()
    setupRegisterButtonWhenSignUpIsSelected()
    showTextFieldsWhenSignUpIsClicked()
    resignAllResponser()
    lostPasswordButton.isHidden = true
  }
}

//MARK: - Tap gesture dismiss keyboard
extension SignInSignUpVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignAllResponser()
  }
}

//MARK: - Dismiss keyboard when done keyboard button is clicked
extension SignInSignUpVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignAllResponser()
    return true
  }
}

//MARK: - Method to resign all responders
extension SignInSignUpVC {
  func resignAllResponser() {
    firstNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
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
