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
    setupMainView()
    setupCancelAndSendButtons()
    setupEmailTextField()
    setupEmailView()
    setupEmailPlaceholder()
    setupSwipeGesture()
    setupOutletsCollectionsOrder()
  }
}

//MARK: - Setup main view design
extension LostPasswordVC {
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Set cancel and send buttons design
extension LostPasswordVC {
  func setupCancelAndSendButtons() {
    cancelAndSendButtons[0].commonDesign(title: .cancel)
    cancelAndSendButtons[1].commonDesign(title: .send)
  }
}

//MARK: - Set email text design
extension LostPasswordVC {
  func setupEmailTextField() {
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }
  
  func setupEmailView() {
    emailView.addBorder(atThe: .bottom, in: .mainBlue)
  }
}

//MARK: - Setup outlet collection to be in order
extension LostPasswordVC {
  func setupOutletsCollectionsOrder() {
    cancelAndSendButtons = cancelAndSendButtons.sorted(by: { $0.tag < $1.tag })
  }
}

//MARK: - Setup email placeholder design
extension LostPasswordVC {
  func setupEmailPlaceholder() {
    emailTextField.setupPlaceholderDesign(title: .email, color: .middleBlue)
  }
}

//MARK: - Setup tap gesture to dismiss keyboard
extension LostPasswordVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    emailTextField.resignFirstResponder()
  }
}

//MARK: - Setup swipe gestures
extension LostPasswordVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
  
  func setupSwipeGesture() {
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeLeft.direction = .left
    swipeRight.direction = .right
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeLeft)
    view.addGestureRecognizer(swipeDown)
    view.addGestureRecognizer(swipeRight)
  }
}

//MARK: - Dismiss keyboard when done is clicked
extension LostPasswordVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    emailTextField.resignFirstResponder()
    return true
  }
}
