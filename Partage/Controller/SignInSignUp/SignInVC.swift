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
  
  @IBOutlet var signInSignUpButtons: [UIButton]!
  @IBOutlet var cancelAndConnectionButtons: [UIButton]!
  @IBOutlet var backgroundTextView: [UIView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
  }
}

//MARK: - Connection button action
extension SignInVC {
  @IBAction func connectionButtonAction(_ sender: Any) {
    
  }
}

//MARK: - Setup main VC design
extension SignInVC {
  func setupMainDesign() {
    setupSignInIsSelectedButtons()
    setupCancelButton()
    setupBackgroundTextView()
    setupAllTextFields()
    setupAllPlaceholders()
    setupConnectionButton()
    setupLostPasswordButton()
    setupDotLabel()
    setupSwipeGesture()
    setupOutletsCollectionsOrder()
  }
}

//MARK: - Setup all delegates
extension SignInVC {
  func setupAllDelegates() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
}

//MARK: - Setup sign in button design
extension SignInVC {
  func setupSignInIsSelectedButtons() {
    signInSignUpButtons[0].signInOrSignUpSelectedDesign(title: .lowSignIn)
    signInSignUpButtons[1].signInOrSignUpUnselectedDesign(title: .lowSignUp)
    signInSignUpButtons[0].isEnabled = false
    signInSignUpButtons[1].isEnabled = true
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
  func setupBackgroundTextView() {
    for view in backgroundTextView {
      view.addBorder(atThe: .bottom, in: .mainBlue)
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
    cancelAndConnectionButtons[0].commonDesign(title: .cancel)
  }
}

//MARK: - Setup sign in connection button design
extension SignInVC {
  func setupConnectionButton() {
    cancelAndConnectionButtons[1].commonDesign(title: .signIn)
  }
}

//MARK: - Setup outlet collection to be in order
extension SignInVC {
  func setupOutletsCollectionsOrder() {
    signInSignUpButtons = signInSignUpButtons.sorted(by: { $0.tag < $1.tag })
    cancelAndConnectionButtons = cancelAndConnectionButtons.sorted(by: { $0.tag < $1.tag })
    backgroundTextView = backgroundTextView.sorted(by: { $0.tag < $1.tag })
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
      performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: self)
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
