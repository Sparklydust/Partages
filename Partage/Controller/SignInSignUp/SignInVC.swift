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

    lostPasswordButton.isHidden = true
  }
}

//MARK: - Buttons actions
extension SignInVC {
  //MARK: Connection button action
  @IBAction func connectionButtonAction(_ sender: Any) {
    userLogin()
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

//MARK: - Design setup
extension SignInVC: UITextFieldDelegate {
  //MARK: Setup sign in button design
  func setupSignInIsSelectedButtons() {
    signInButton.signInOrSignUpSelectedDesign(title: .lowSignIn)
    signUpButton.signInOrSignUpUnselectedDesign(title: .lowSignUp)
    signInButton.isEnabled = false
    signUpButton.isEnabled = true
  }

  //MARK: Setup dot label design
  func setupDotLabel() {
    dotLabel.isSelectedDesign()
  }

  //MARK: Setup background text view design
  func setupUnderlinesView() {
    for underline in underlineViews {
      underline.setupBackgroundColorIn(.mainBlue)
    }
  }

  //MARK: Setup all text fields design
  func setupAllTextFields() {
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    passwordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }

  //MARK: Setup cancel button design
  func setupCancelButton() {
    cancelButton.commonDesign(title: .cancel)
  }

  //MARK: Setup sign in connection button design
  func setupConnectionButton() {
    connectionButton.commonDesign(title: .signIn)
  }

  //MARK: Setup all placeholders design
  func setupAllPlaceholders() {
    emailTextField.setupPlaceholderDesign(title: .email, color: .middleBlue)
    passwordTextField.setupPlaceholderDesign(title: .password, color: .middleBlue)
  }

  //MARK: Setup lost password design
  func setupLostPasswordButton() {
    lostPasswordButton.littleButtonDesign(title: .lowLostPassword, color: .typoBlue)
  }
}

//MARK: - Setup tap gesture to dismiss keyboard
extension SignInVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignAllResponder()
  }
}

//MARK: - Setup swipe gestures
extension SignInVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .left {
      performSegue(withIdentifier: Segue.goToSignUpVC.rawValue, sender: self)
    }
    if sender.direction == .down {
      guard emailTextField.isFirstResponder || passwordTextField.isFirstResponder else {
        performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
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
  func resignAllResponder() {
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
  }
}

//MARK: - Dismiss keyboard when done keyboard button is clicked
extension SignInVC {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignAllResponder()
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
    signUpButton.isEnabled = false
    swipeGestureRecognizer.isEnabled = false
  }

  func hideActivityIndicator() {
    ConnectionActivityIndicator.isHidden = true
    connectionButton.commonDesign(title: .signIn)
    signUpButton.isEnabled = true
    swipeGestureRecognizer.isEnabled = true
  }
}

//MARK: - Method for the user to log in
extension SignInVC {
  func userLogin() {
    guard let email = emailTextField.text, !email.isEmpty else {
      showAlert(title: .emailErrorTitle, message: .addEmail)
      return
    }
    guard let password = passwordTextField.text, !password.isEmpty else {
      showAlert(title: .passwordErrorTitle, message: .passwordDoesntMatch)
      return
    }
    resignAllResponder()
    triggerActivityIndicator(true)
    Auth().login(email: email, password: password) { (result) in
      switch result {
      case .success:
        DispatchQueue.main.async {
          self.performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
          self.triggerActivityIndicator(false)
        }
      case .failure:
        DispatchQueue.main.async {
          self.showAlert(title: .loginErrorTitle, message: .loginError)
          self.triggerActivityIndicator(false)
        }
      }
    }
  }
}
