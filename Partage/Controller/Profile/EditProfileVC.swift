//
//  EditProfileVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
  
  @IBOutlet weak var firstNameView: UIView!
  @IBOutlet weak var confirmPasswordView: UIView!
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var oldPasswordTextField: UITextField!
  @IBOutlet weak var newPasswordTextField: UITextField!
  
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBOutlet var staticLabel: [UILabel]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSpecificCornerRadius()
    setupFonts()
    observeKeyboardNotification()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Cancel Button action
extension EditProfileVC {
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - Save Button action
extension EditProfileVC {
  @IBAction func saveButton(_ sender: Any) {
  }
}

//MARK: - Setup corner radius at top right and bottom right
extension EditProfileVC {
  func setupSpecificCornerRadius() {
    roundCorners(view: firstNameView, corners: .topRight, radius: 20)
    roundCorners(view: firstNameTextField, corners: .topRight, radius: 20)
    roundCorners(view: confirmPasswordView, corners: .bottomRight, radius: 20)
    roundCorners(view: confirmPasswordTextField, corners: .bottomRight, radius: 20)
  }
}

//MARK: - Setup all fonts in VC
extension EditProfileVC {
  func setupFonts() {
    userEntriesFont()
    setupButtons()
    staticLabelFont()
  }
  
  func userEntriesFont() {
    firstNameTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    lastNameTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    emailTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    oldPasswordTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    newPasswordTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
  }
  
  func setupButtons() {
    cancelButton.commonDesign(title: .cancel, shadowWidth: 0, shadowHeight: -2)
    saveButton.commonDesign(title: .save, shadowWidth: 0, shadowHeight: 2)
  }
  
  func staticLabelFont() {
    for label in staticLabel {
      label.font = UIFont(customFont: .editLabelFont, withSize: .staticLabelSize)
    }
  }
}

//MARK: - Tap gesture acton to dismiss keyboard
extension EditProfileVC {
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    resignTextFieldResponders()
  }
}

//MARK: - Dismiss keyboard when done button is clicked
extension EditProfileVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    resignTextFieldResponders()
    return true
  }
  
  func resignTextFieldResponders() {
    firstNameTextField.resignFirstResponder()
    lastNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    oldPasswordTextField.resignFirstResponder()
    newPasswordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
  }
}

//MARK: - Handle hidden text field on iPhone SE
extension EditProfileVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    guard UIDevice.current.name == "iPhone SE" else { return }
    if confirmPasswordTextField.isEditing || newPasswordTextField.isEditing {
      if view.frame.origin.y == 0 {
        UIView.animate(withDuration: 0.4) {
          self.view.frame.origin.y -= (keyboardFrame.height / 3)
        }
      }
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    if view.frame.origin.y != 0 {
      UIView.animate(withDuration: 0.4) {
        self.view.frame.origin.y = 0
      }
    }
  }
}
