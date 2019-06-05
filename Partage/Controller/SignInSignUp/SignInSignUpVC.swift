//
//  SignInSignUpVC.swift
//  Partage
//
//  Created by Roland Lariotte on 05/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SignInSignUpVC: UIViewController {
  
  @IBOutlet var signInSignUpButtons: [UIButton]!
  @IBOutlet var dotLabels: [UILabel]!
  @IBOutlet var cancelAndRegisterButtons: [UIButton]!
  @IBOutlet var backgroundTextView: [UIView]!
  
  @IBOutlet weak var lostPasswordButton: UIButton!
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  
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
      self.setSignInIsSelectedButtons()
      self.setRegisterButtonWhenSignInIsSelected()
      self.hideTextFieldWhenSignInIsClicked()
      self.resignAllResponser()
    }
  }
  
  @IBAction func signUpButtonAction(_ sender: Any) {
    UIView.animate(withDuration: 0.3) {
      self.setSignUpIsSelectedButtons()
      self.setRegisterbuttonWhenSignUpIsSelected()
      self.showTextFieldWhenSignUpIsClicked()
      self.resignAllResponser()
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

//MARK: Set sign in / sign up buttons design
extension SignInSignUpVC {
  func setSignInIsSelectedButtons() {
    signInSignUpButtons[0].signInSignUpSelectedDesign(title: .lowSignIn)
    signInSignUpButtons[1].signInSignUpUnselectedDesign(title: .lowSignUp)
    signInSignUpButtons[0].isEnabled = false
    signInSignUpButtons[1].isEnabled = true
    dotLabels[0].textColor = UIColor.mainBlue
    dotLabels[1].textColor = UIColor.typoBlue
  }
  
  func setSignUpIsSelectedButtons() {
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
  func setCancelButton() {
    cancelAndRegisterButtons[0].commonDesign(title: .cancel, shadowWidth: 0, shadowHeight: -2)
  }
  
  func setRegisterButtonWhenSignInIsSelected() {
    cancelAndRegisterButtons[1].commonDesign(title: .signIn, shadowWidth: 0, shadowHeight: 2)
  }
  
  func setRegisterbuttonWhenSignUpIsSelected() {
    cancelAndRegisterButtons[1].commonDesign(title: .signUp, shadowWidth: 0, shadowHeight: 2)
  }
}

//MARK: - Set lost password design
extension SignInSignUpVC {
  func setLostPasswordButton() {
    lostPasswordButton.littleDesign(title: .lowLostPassword, color: .typoBlue)
  }
}

//MARK: - Set background text view design
extension SignInSignUpVC {
  func setBackgroundTextViewDesign() {
    for view in backgroundTextView {
      view.backgroundColor = UIColor.mainBlue
      view.layer.cornerRadius = 10
    }
  }
}

//MARK: - Set text field design
extension SignInSignUpVC {
  func setAllTextFieldsDesign() {
    firstNameTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    emailTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    passwordTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    confirmPasswordTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    firstNameTextField.textColor = UIColor.iceBackground
    emailTextField.textColor = UIColor.iceBackground
    passwordTextField.textColor = UIColor.iceBackground
    confirmPasswordTextField.textColor = UIColor.iceBackground
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

//MARK: - Setup main VC design
extension SignInSignUpVC {
  func setupMainDesign() {
    setSignInIsSelectedButtons()
    setRegisterButtonWhenSignInIsSelected()
    setCancelButton()
    setLostPasswordButton()
    setBackgroundTextViewDesign()
    setAllTextFieldsDesign()
    hideTextFieldWhenSignInIsClicked()
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
