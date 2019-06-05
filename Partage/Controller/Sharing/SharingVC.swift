//
//  SharingVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

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
    shareButton.shareReceiveDesign(title: .shareMain, shadowHeight: -2)
    receiveButton.shareReceiveDesign(title: .receiveMain, shadowHeight: 2)
    signInSignUpButton.signInSignUpDesign(title: .signInSignUp)
  }
}
