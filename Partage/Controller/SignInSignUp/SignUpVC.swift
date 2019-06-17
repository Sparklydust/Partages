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
  
  @IBOutlet var signInSignUpButtons: [UIButton]!
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
extension SignUpVC {
  @IBAction func registerButtonAction(_ sender: Any) {
    
  }
}

//MARK: - Setup main VC design
extension SignUpVC {
  func setupMainDesign() {
    setupSignUpIsSelectedButtons()
    setupCancelButton()
    setupBackgroundTextView()
    setupAllTextFields()
    setupAllPlaceholders()
    setupRegisterButton()
    setupDotLabel()
    setupSwipeGesture()
    setupOutletsCollectionsOrder()
  }
}

//MARK: - Setup all delegates
extension SignUpVC {
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
    signInSignUpButtons[0].signInOrSignUpUnselectedDesign(title: .lowSignIn)
    signInSignUpButtons[1].signInOrSignUpSelectedDesign(title: .lowSignUp)
    signInSignUpButtons[0].isEnabled = true
    signInSignUpButtons[1].isEnabled = false
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
    cancelAndRegisterButtons[0].commonDesign(title: .cancel)
  }
}

//MARK: - Setup sign up user register button design
extension SignUpVC {
  func setupRegisterButton() {
    cancelAndRegisterButtons[1].commonDesign(title: .signUp)
  }
}

//MARK: - Setup background text view design
extension SignUpVC {
  func setupBackgroundTextView() {
    for view in backgroundTextView {
      view.addBorder(atThe: .bottom, in: .mainBlue)
    }
  }
}

//MARK: - Setup outlet collection to be in order
extension SignUpVC {
  func setupOutletsCollectionsOrder() {
    signInSignUpButtons = signInSignUpButtons.sorted(by: { $0.tag < $1.tag })
    cancelAndRegisterButtons = cancelAndRegisterButtons.sorted(by: { $0.tag < $1.tag })
    backgroundTextView = backgroundTextView.sorted(by: { $0.tag < $1.tag })
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
    confirmPasswordTextField.setupPlaceholderDesign(title: .fullConfirmPassword, color: .middleBlue)
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
      performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: self)
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
