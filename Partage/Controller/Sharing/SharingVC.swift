//
//  SharingVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SharingVC: UIViewController {
  
  @IBAction func unwindToSharingVC(segue: UIStoryboardSegue) { }
  
  @IBOutlet weak var shareButton: UIButton!
  @IBOutlet weak var signInSignUpButton: UIButton!
  @IBOutlet weak var receiveButton: UIButton!
  @IBOutlet weak var activityIndicatorReceive: UIActivityIndicatorView!
  
  private var donatorsItems = [DonatorItem]()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(true, animated: false)
    triggerActivityIndicator(false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
  }
}

//MARK: - Buttons actions
extension SharingVC {
  //MARK: - Share Button action
  @IBAction func shareButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goesToDonatorVC.rawValue, sender: self)
  }
  
  //MARK: - SignInSignUp button action
  @IBAction func signInSignUpButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goesToSignInSignUpVC.rawValue, sender: self)
  }
  
  //MARK: - Receiver Button Action
  @IBAction func receiverButtonAction(_ sender: Any) {
    triggerActivityIndicator(true)
  }
}

//MARK: - Main setup
extension SharingVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupAllButtons()
    setupNavigationController()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Setup all buttons
extension SharingVC {
  func setupAllButtons() {
    shareButton.shareReceiveDesign(title: .shareMain)
    receiveButton.shareReceiveDesign(title: .receiveMain)
    signInSignUpButton.signInSignUpDesign(title: .signInSignUp)
  }
}

//MARK: - Setup navigation controller design
extension SharingVC {
  func setupNavigationController() {
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.tintColor = .typoBlue
    navigationController?.navigationBar.barTintColor = .iceBackground
    navigationController?.navigationBar.isTranslucent = false
  }
}

//MARK: - Activity Indicator action and setup
extension SharingVC {
  func triggerActivityIndicator(_ action: Bool) {
    guard action else {
      hideActivityIndicator()
      return
    }
    showActivityIndicator()
  }
  
  func showActivityIndicator() {
    activityIndicatorReceive.isHidden = false
    activityIndicatorReceive.style = .whiteLarge
    activityIndicatorReceive.color = .iceBackground
    view.addSubview(activityIndicatorReceive)
    activityIndicatorReceive.startAnimating()
    receiveButton.shareReceiveDesign(title: .emptyString)
    receiveButton.isHidden = false
  }
  
  func hideActivityIndicator() {
    activityIndicatorReceive.isHidden = true
    receiveButton.shareReceiveDesign(title: .receiveMain)
  }
}

//MARK: - Prepare for segue method
extension SharingVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goesToReceiverVC.rawValue {
      let destinationVC = segue.destination as! ReceiverVC
      destinationVC.donatorsItems = donatorsItems
    }
  }
}
