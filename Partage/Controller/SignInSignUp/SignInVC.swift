//
//  SignInVC.swift
//  Partage
//
//  Created by Roland Lariotte on 16/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignInVC: UIViewController {

  @IBAction func unwindToSignInVC(segue: UIStoryboardSegue) { }

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var dotLabel: UILabel!
  @IBOutlet weak var orLabel: UILabel!
  @IBOutlet weak var lostPasswordButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var connectionButton: UIButton!
  @IBOutlet weak var ConnectionActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var swipeGestureRecognizer: UISwipeGestureRecognizer!
  @IBOutlet weak var orLabelLayoutConstraint: NSLayoutConstraint!
  
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
    setupLabels()
    setupSwipeGesture()
    setupPasswordAutoFill()
    //setupSignInWithApple()
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
  func setupLabels() {
    dotLabel.isSelectedDesign()
  }

  //MARK: Setup of label for sign in with Apple
  func setupOrLabel() {
    orLabel.text = StaticLabel.or.description
    if let whiteBlueDarkModeColor = UIColor.mainBlueIceWhiteDarkMode {
    orLabel.setupFont(as: .arial, sized: .fifteen, forIPad: .twentyTwo, in: whiteBlueDarkModeColor)
    }
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
      emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
      passwordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
    }
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
    if let darkModeColor = UIColor.typoBlueDarkMode {
      lostPasswordButton.littleButtonDesign(title: .lowLostPassword, color: darkModeColor)
    }
  }

  //MARK: Setup email and password for auto fill
  func setupPasswordAutoFill() {
    emailTextField.textContentType = .username
    emailTextField.keyboardType = .emailAddress
    passwordTextField.textContentType = .password
  }

  //MARK: Setup Sign In With Apple
  func setupSignInWithApple() {
    var signInWithAppleButton: ASAuthorizationAppleIDButton
    if traitCollection.userInterfaceStyle == .dark {
      signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    }
    else {
      signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    setupDesign(of: signInWithAppleButton)
    signInWithAppleButton.addTarget(
      self, action: #selector(handleSignInWithAppleButtonPress), for: .touchDown)
  }

  //MARK: Setup Sign in with Apple button position
  func setupDesign(of button: ASAuthorizationAppleIDButton) {
    setupOrLabel()
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.widthAnchor.constraint(equalTo: connectionButton.widthAnchor),
      button.heightAnchor.constraint(equalTo: connectionButton.heightAnchor),
      button.topAnchor.constraint(equalTo: orLabel.bottomAnchor,
                                  constant: orLabelLayoutConstraint.constant)
    ])
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
    ConnectionActivityIndicator.style = UIActivityIndicatorView.Style.large
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

//MARK: - API Calls
extension SignInVC {
  //MARK: Method for the user to log in
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
      case .failure:
        DispatchQueue.main.async {
          self.showAlert(title: .loginErrorTitle, message: .loginError)
          self.triggerActivityIndicator(false)
        }
      case .success:
        DispatchQueue.main.async {
          self.performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
          self.triggerActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Sign in with Apple button pressed actions
extension SignInVC: ASAuthorizationControllerDelegate {
  @objc func handleSignInWithAppleButtonPress() {
    DispatchQueue.main.async {
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }
  }
}

//MARK: - Sign in with Apple Authorization handler
extension SignInVC: ASAuthorizationControllerPresentationContextProviding {
  //MARK: Succesfull authorization returns user info
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
    case let credentials as ASAuthorizationAppleIDCredential:
      let user = FullUser(credentials: credentials)
      print("appleID: \(credentials.user) user: \(user.email) name: \(user.firstName) \(user.lastName)")
      
      //TODO: Call a method to save a user when he is athorized by Apple to 'Sign in with Apple'
      
      UserDefaultsService.shared.signedInWithApple = true
      performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
      break
    case let credentials as ASPasswordCredential:
      let userName = credentials.user
      let password = credentials.password
      
      //TODO: Call a method to save a user when ha used password credentials
      
      print("user name is: \(userName) password: \(password)")
      break
    default: break
    }
  }

  //MARK: Error handler
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    showAlert(title: .errorTitle, message: .networkRequestError)
    print(error.localizedDescription)
  }

  //MARK: show on screen Apple sign view with info to user
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return view.window!
  }
}
