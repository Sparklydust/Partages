//
//  SharingVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

enum ShareDisplayButtonName: String {
  case share = "Je partage"
  case signInSignUp = "se connecter / s'inscrire"
  case afterSignedIn = "Bonjour"
  case donationMade = "Merci pour votre don"
  case receive = "Je reçois"
}

class SharingVC: UIViewController {
  
  @IBOutlet weak var shareButton: UIButton!
  @IBOutlet weak var signInSignUpButton: UIButton!
  @IBOutlet weak var receiveButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAllButtonsDisplayed()
  }
}

//MARK: - Setup all buttons
extension SharingVC {
  func setupAllButtonsDisplayed() {
    shareButton.shareReceiveDesign(title: ShareDisplayButtonName.share.rawValue, shadowOffsetHeight: -2)
    receiveButton.shareReceiveDesign(title: ShareDisplayButtonName.receive.rawValue, shadowOffsetHeight: 2)
    signInSignUpButton.signInSignUpDesign(title: ShareDisplayButtonName.signInSignUp.rawValue)
  }
}
