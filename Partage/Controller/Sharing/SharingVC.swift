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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAllButtons()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
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
