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
  @IBOutlet weak var underlineView: UIView!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    setupMainDesign()
  }
}

//MARK: - Buttons actions
extension LostPasswordVC {
  //MARK: Send password button action
  @IBAction func sendPasswordButtonAction(_ sender: Any) {
  }
  
  //MARK: Cancel button action
  @IBAction func cancelButtonActions(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - Main setup
extension LostPasswordVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupCancelAndSendButtons()
    setupEmailTextField()
    setupUnderlineView()
    setupEmailPlaceholder()
    setupSwipeGesture()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Set cancel and send buttons design
extension LostPasswordVC {
  func setupCancelAndSendButtons() {
    cancelButton.commonDesign(title: .cancel)
    saveButton.commonDesign(title: .send)
  }
}

//MARK: - Set email text design
extension LostPasswordVC {
  func setupEmailTextField() {
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }
  
  func setupUnderlineView() {
    underlineView.setupBackgroundColorIn(.mainBlue)
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
    if sender.direction == .down {
      guard emailTextField.isFirstResponder else {
        dismiss(animated: true, completion: nil)
        return
      }
      view.endEditing(true)
    }
    else {
      dismiss(animated: true, completion: nil)
    }
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
