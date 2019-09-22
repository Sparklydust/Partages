//
//  SharingVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SharingVC: UIViewController {

  @IBOutlet weak var shareButton: UIButton!
  @IBOutlet weak var signInSignUpButton: UIButton!
  @IBOutlet weak var receiveButton: UIButton!
  @IBOutlet weak var activityIndicatorReceive: UIActivityIndicatorView!

  var donatedItems = [DonatedItem]()

  var interstitial: GADInterstitial!
  var displayAd = false

  var user: User? {
    didSet {
      populateUserInfoOnSignInButton()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupGoogleInterstitialAd()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
    populateSignInSignUpButtonDesign()
    displayGoogleAdIfAuthorized()
  }
}

//MARK: - Unwind Segue retrieve data from DonorVC, ItemSelectedVC and SignUpVC
extension SharingVC {
  @IBAction func unwindToSharingVC(segue: UIStoryboardSegue) {
    if segue.source is DonorVC {
      if let senderVC = segue.source as? DonorVC {
        senderVC.authToDisplayGoogleAd = displayAd
      }
    }
    else if segue.source is ItemSelectedVC {
      if let senderVC = segue.source as? ItemSelectedVC {
        senderVC.authToDisplayGoogleAd = displayAd
      }
    }
    else if segue.source is SignUpVC {
      populateSignInSignUpButtonDesign()
    }
    else if segue.source is SignInVC {
      populateSignInSignUpButtonDesign()
    }
  }
}

//MARK: - Buttons actions
extension SharingVC {
  //MARK: Share Button action
  @IBAction func shareButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToDonatorVC.rawValue, sender: self)
  }

  //MARK: SignInSignUp button action
  @IBAction func signInSignUpButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToSignInSignUpVC.rawValue, sender: self)
  }

  //MARK: Receiver Button Action
  @IBAction func receiverButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToReceiverVC.rawValue, sender: self)
  }
}

//MARK: - Main setup
extension SharingVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupShareReceiveButtons()
    setupNavigationController()
  }

  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Design setup
extension SharingVC {
//MARK: Setup all buttons
  func setupShareReceiveButtons() {
    shareButton.shareReceiveDesign(title: .shareMain)
    receiveButton.shareReceiveDesign(title: .receiveMain)
  }

  //MARK: Setup navigation controller design
  func setupNavigationController() {
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.tintColor = .typoBlueDarkMode
    navigationController?.navigationBar.barTintColor = .iceBackgroundDarkMode
    navigationController?.navigationBar.isTranslucent = false
  }
}

//MARK: - API Calls
extension SharingVC {
  //MARK: Fetch user from the database
  func fetchUserFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }

    let resourcePath = NetworkPath.users.description + UserDefaultsService.shared.userID!
    ResourceRequest<User>(resourcePath).get(tokenNeeded: true) { [weak self] (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.deleteUserFromUserDefaults()
          self?.populateUserInfoOnSignInButton()
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success(let user):
        DispatchQueue.main.async { [weak self] in
          self?.user = user
        }
      }
    }
  }
}

//MARK: - User sign in change SignInSignUp button
extension SharingVC {
  func populateSignInSignUpButtonDesign() {
    if UserDefaultsService.shared.userToken != nil {
      fetchUserFromTheDatabase()
      signInSignUpButton.signInSignUpDesign(title: ButtonName.afterSignedIn.description)
      signInSignUpButton.isEnabled = false
    }
    else {
      signInSignUpButton.signInSignUpDesign(title: ButtonName.signInSignUp.description)
      signInSignUpButton.isEnabled = true
    }
  }
}

//MARK: - Populate user info after logged in
extension SharingVC {
  func populateUserInfoOnSignInButton() {
    guard let firstName = user?.firstName else { return }
    let helloUser = ButtonName.afterSignedIn.description + firstName
    signInSignUpButton.setTitle(helloUser , for: .normal)
  }
}

//MARK: - Google ad as interstital registration and use
extension SharingVC {
  func setupGoogleInterstitialAd() {
    interstitial = GADInterstitial(adUnitID: GoogleAd.unitID.description)
    let request = GADRequest()
    interstitial.load(request)
  }

  func displayGoogleAdIfAuthorized() {
    if displayAd {
      guard interstitial.isReady else { return }
      interstitial.present(fromRootViewController: self)
      displayAd = false
      interstitial = createNewGoogleAd()
    }
  }

  func createNewGoogleAd() -> GADInterstitial {
    let newInterstitial = GADInterstitial(adUnitID: GoogleAd.unitID.description)
    newInterstitial.load(GADRequest())
    return newInterstitial
  }
}

//MARK: - Delete user inside user defaults
extension SharingVC {
  func deleteUserFromUserDefaults() {
    UserDefaultsService.shared.userToken = nil
    UserDefaultsService.shared.userID = nil
  }
}
