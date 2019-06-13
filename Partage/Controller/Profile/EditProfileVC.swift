//
//  EditProfileVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var oldPasswordTextField: UITextField!
  @IBOutlet weak var newPasswordTextField: UITextField!
  
  @IBOutlet var cancelAndSaveButtons: [UIButton]!
  @IBOutlet var backgroundViews: [UIView]!
  @IBOutlet var staticLabels: [UILabel]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
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

//MARK: - Setup main developer design
extension EditProfileVC {
  func setupMainDesign() {
    setupBackgroundViews()
    setupAllUserTextFields()
    setupButtons()
    setupStaticLabels()
    setupAllPlaceholders()
  }
}

//MARK: - Setup all views background text field views design
extension EditProfileVC {
  func setupBackgroundViews() {
    for view in backgroundViews {
      view.layer.cornerRadius = 10
      view.layer.borderWidth = 1
      view.layer.borderColor = UIColor.mainBlue.cgColor
    }
  }
}

//MARK: - Setup all user entry text fields design
extension EditProfileVC{
  func setupAllUserTextFields() {
    firstNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    lastNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    emailTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    oldPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    newPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
    confirmPasswordTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .mainBlue)
  }
}

//MARK: - Setup cancel and save buttons design
extension EditProfileVC {
  func setupButtons() {
    cancelAndSaveButtons[0].commonDesign(title: .cancel, shadowWidth: 0, shadowHeight: -2)
    cancelAndSaveButtons[1].commonDesign(title: .save, shadowWidth: 0, shadowHeight: 2)
  }
}

//MARK: - Setup all static labels design
extension EditProfileVC {
  func setupStaticLabels() {
    staticLabels[0].text = StaticLabel.firsName.rawValue
    staticLabels[1].text = StaticLabel.lastName.rawValue
    staticLabels[2].text = StaticLabel.email.rawValue
    staticLabels[3].text = StaticLabel.password.rawValue
    for label in staticLabels {
      label.setupFont(as: .arialBold, sized: .fourteen, in: .typoBlue)
    }
  }
}

//MARK: - Setup placeholders design
extension EditProfileVC {
  func setupAllPlaceholders() {
    oldPasswordTextField.setupPlaceholderDesign(title: .oldPassword, color: .typoBlue)
    newPasswordTextField.setupPlaceholderDesign(title: .newPassword, color: .typoBlue)
    confirmPasswordTextField.setupPlaceholderDesign(title: .confirmPassword, color: .typoBlue)
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
}

//MARK: - All text field resign first responder method
extension EditProfileVC {
  func resignTextFieldResponders() {
    firstNameTextField.resignFirstResponder()
    lastNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    oldPasswordTextField.resignFirstResponder()
    newPasswordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
  }
}

//MARK: - Handle to show hidden text field on iPhone SE
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
    guard confirmPasswordTextField.isEditing || newPasswordTextField.isEditing else { return }
    guard view.frame.origin.y == 0 else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y -= (keyboardFrame.height / 3)
    }
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    guard view.frame.origin.y != 0 else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y = 0
    }
  }
}
