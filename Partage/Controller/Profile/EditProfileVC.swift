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
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var confirmPasswordView: UIView!
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
    
//    // Listen for keyboard events
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
//
//  // Stop Listening for keyboard hide/show events
//  deinit {
//    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//  }
//
//  @objc func keyboardWillChange(notification: Notification) {
//    guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//      return
//    }
//    if notification.name == UIResponder.keyboardWillShowNotification ||
//    notification.name == UIResponder.keyboardWillChangeFrameNotification {
//      view.frame.origin.y = -keyboardRect.height
//    }
//    else {
//      confirmPasswordTextField.resignFirstResponder()
//      view.frame.origin.y = 0
//    }
//  }
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

//MARK: - Setup all fonts in View Controller
extension EditProfileVC {
  func setupFonts() {
    userEntriesFont()
    buttonsFont()
    staticLabelFont()
  }
  
  func userEntriesFont() {
    firstNameTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    lastNameTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    emailTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    oldPasswordTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
    newPasswordTextField.font = UIFont(customFont: .mainAppFont, withSize: .mainSize)
  }
  
  func buttonsFont() {
    cancelButton.titleLabel?.font = UIFont(customFont: .buttonFont, withSize: .mainSize)
    saveButton.titleLabel?.font = UIFont(customFont: .buttonFont, withSize: .mainSize)
  }
  
  func staticLabelFont() {
    for label in staticLabel {
      label.font = UIFont(customFont: .editLabelFont, withSize: .staticLabelSize)
    }
  }
}
