//
//  LostPasswordVC.swift
//  Partage
//
//  Created by Roland Lariotte on 05/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class LostPasswordVC: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var emailView: UIView!
  
  @IBOutlet var cancelAndSendButtons: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    setupMainDesign()
  }
}

//MARK: - Send password button action
extension LostPasswordVC {
  @IBAction func sendPasswordButtonAction(_ sender: Any) {
  }
}

//MARK: - Cancel button action
extension LostPasswordVC {
  @IBAction func cancelButtonActions(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - Setup developer main design
extension LostPasswordVC {
  func setupMainDesign() {
    setupCancelAndSendButtons()
    setupEmailTextField()
    setupEmailView()
    setupEmailPlaceholder()
  }
}

//MARK: - Set cancel and send buttons design
extension LostPasswordVC {
  func setupCancelAndSendButtons() {
    cancelAndSendButtons[0].commonDesign(title: .cancel, shadowWidth: 0, shadowHeight: -2)
    cancelAndSendButtons[1].commonDesign(title: .send, shadowWidth: 0, shadowHeight: 2)
  }
}

//MARK: - Set email text design
extension LostPasswordVC {
  func setupEmailTextField() {
    emailTextField.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    emailTextField.textColor = UIColor.iceBackground
    emailTextField.layer.cornerRadius = 10
  }
  
  func setupEmailView() {
    emailView.backgroundColor = UIColor.mainBlue
    emailView.layer.cornerRadius = 10
  }
}

//MARK: - Setup email placeholder design
extension LostPasswordVC {
  func setupEmailPlaceholder() {
    emailTextField.setupPlaceholderDesign(title: .email, color: UIColor.iceBackground)
  }
}

//MARK: - Tap gesture dismiss keyboard
extension LostPasswordVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    emailTextField.resignFirstResponder()
  }
}

//MARK: - Dismiss keyboard when done is clicked
extension LostPasswordVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    emailTextField.resignFirstResponder()
    return true
  }
}
