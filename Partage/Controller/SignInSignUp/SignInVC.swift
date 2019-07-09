//
//  SignInVC.swift
//  Partage
//
//  Created by Roland Lariotte on 16/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
  
  @IBAction func unwindToSignInVC(segue: UIStoryboardSegue) { }
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var dotLabel: UILabel!
  @IBOutlet weak var lostPasswordButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var connectionButton: UIButton!
  @IBOutlet weak var ConnectionActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var swipeGestureRecognizer: UISwipeGestureRecognizer!
  
  @IBOutlet var underlineViews: [UIView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    triggerActivityIndicator(false)
  }
}

//MARK: - Buttons actions
extension SignInVC {
  //MARK: Connection button action
  @IBAction func connectionButtonAction(_ sender: Any) {
  }
}

//MARK: - Main setup
extension SignInVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupSignInIsSelectedButtons()
    setupCancelButton()
    setupUnderlinesView()
    setupAllTextFields()
    setupAllPlaceholders()
    setupConnectionButton()
    setupLostPasswordButton()
    setupDotLabel()
    setupSwipeGesture()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
  
  //MARK: All delegates
  func setupAllDelegates() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
}

//MARK: - Setup sign in button design
extension SignInVC {
  func setupSignInIsSelectedButtons() {
    signInButton.signInOrSignUpSelectedDesign(title: .lowSignIn)
    signUpButton.signInOrSignUpUnselectedDesign(title: .lowSignUp)
    signInButton.isEnabled = false
    signUpButton.isEnabled = true
  }
}

//MARK: - Setup dot label design
extension SignInVC {
  func setupDotLabel() {
    dotLabel.isSelectedDesign()
  }
}

//MARK: - Setup background text view design
extension SignInVC {
  func setupUnderlinesView() {
    for underline in underlineViews {
      underline.setupBackgroundColorIn(.mainBlue)
    }
  }
}

//MARK: - Setup all text fields design
extension SignInVC: UITextFieldDelegate {
  func setupAllTextFields() {
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    passwordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }
}

///MARK: - Setup cancel button design
extension SignInVC {
  func setupCancelButton() {
    cancelButton.commonDesign(title: .cancel)
  }
}

//MARK: - Setup sign in connection button design
extension SignInVC {
  func setupConnectionButton() {
    connectionButton.commonDesign(title: .signIn)
  }
}

//MARK: - Setup all placeholders design
extension SignInVC {
  func setupAllPlaceholders() {
    emailTextField.setupPlaceholderDesign(title: .email, color: .middleBlue)
    passwordTextField.setupPlaceholderDesign(title: .password, color: .middleBlue)
  }
}

//MARK: - Setup tap gesture to dismiss keyboard
extension SignInVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignAllResponser()
  }
}

//MARK: - Setup lost password design
extension SignInVC {
  func setupLostPasswordButton() {
    lostPasswordButton.littleButtonDesign(title: .lowLostPassword, color: .typoBlue)
  }
}

//MARK: - Setup swipe gestures
extension SignInVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .left {
      performSegue(withIdentifier: Segue.goesToSignUpVC.rawValue, sender: self)
    }
    if sender.direction == .down {
      guard emailTextField.isFirstResponder || passwordTextField.isFirstResponder else {
        performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: self)
        return
      }
      view.endEditing(true)
    }
  }
  
  func setupSwipeGesture() {
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeLeft.direction = .left
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeLeft)
    view.addGestureRecognizer(swipeDown)
  }
}

//MARK: - Method to resign all responders
extension SignInVC {
  func resignAllResponser() {
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
  }
}

//MARK: - Dismiss keyboard when done keyboard button is clicked
extension SignInVC {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignAllResponser()
    return true
  }
}

//MARK: - Activity Indicator action and setup
extension SignInVC {
  func triggerActivityIndicator(_ action: Bool) {
    guard action else {
      hideActivityIndicator()
      return
    }
    showActivityIndicator()
  }
  
  func showActivityIndicator() {
    ConnectionActivityIndicator.isHidden = false
    ConnectionActivityIndicator.style = .whiteLarge
    ConnectionActivityIndicator.color = .iceBackground
    view.addSubview(ConnectionActivityIndicator)
    ConnectionActivityIndicator.startAnimating()
    connectionButton.commonDesign(title: .emptyString)
    connectionButton.isHidden = false
    cancelButton.isEnabled = false
    signUpButton.isEnabled = false
    swipeGestureRecognizer.isEnabled = false
  }
  
  func hideActivityIndicator() {
    ConnectionActivityIndicator.isHidden = true
    connectionButton.commonDesign(title: .signIn)
    cancelButton.isEnabled = true
    signUpButton.isEnabled = true
    swipeGestureRecognizer.isEnabled = true
  }
}
