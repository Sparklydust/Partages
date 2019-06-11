//
//  DonatorVC.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MapKit

class DonatorVC: UIViewController {
  
  @IBOutlet weak var itemTypePickerView: UIPickerView!
  @IBOutlet weak var itemDatePicker: UIDatePicker!
  
  @IBOutlet weak var itemNameTextField: UITextField!
  
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  
  @IBOutlet weak var addItemImageButton: UIButton!
  @IBOutlet weak var mapKitButton: UIButton!
  
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet weak var littleBarView: UIView!
  @IBOutlet weak var itemDescriptionBackgroundView: UIView!
  
  @IBOutlet var resetAndDonateButton: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainAppDesign()
    setupAllDelegates()
    observeKeyboardNotification()
    hideKeyboardOnTapGesture()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Add item image button action
extension DonatorVC {
  @IBAction func addItemImageButtonAction(_ sender: Any) {
  }
}

//MARK: - Map kit button action
extension DonatorVC {
  @IBAction func mapKitButtonAction(_ sender: Any) {
  }
}

//MARK: - Reset Button Action
extension DonatorVC {
  @IBAction func resetButtonAction(_ sender: Any) {
  }
}

//MARK: - Make a donation button action
extension DonatorVC {
  @IBAction func makeADonationButtonAction(_ sender: Any) {
  }
}

//MARK: - Setup developer main design
extension DonatorVC {
  func setupMainAppDesign() {
    navigationItem.setupNavBarProfileImage()
    setupResetAndDonateButton()
    setupItemNameTextField()
    setupItemNameTextFieldPlaceholder()
    setupLittleBarViewDesign()
    setupItemDescriptionTextView()
    setupItemDescriptionBackgroundView()
    setupMapView()
  }
}

//MARK: - Setup all view controllers delegates
extension DonatorVC {
  func setupAllDelegates() {
    itemTypePickerView.delegate = self
    itemTypePickerView.dataSource = self
    itemDescriptionTextView.delegate = self
  }
}

//MARK: - Setup item type picker view design and data
extension DonatorVC: UIPickerViewDelegate, UIPickerViewDataSource {
  func setupItemPicker() {
    itemTypePickerView.backgroundColor = UIColor.iceBackground
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return DonatorItem.type.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return DonatorItem.type[row].rawValue
  }
}

//MARK: - Setup date picker design
extension DonatorVC {
  func setupDatePicker() {
    itemDatePicker.backgroundColor = UIColor.iceBackground
  }
}

//MARK: - Setup item name text field design
extension DonatorVC {
  func setupItemNameTextField() {
    itemNameTextField.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    itemNameTextField.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup item text field placeholder
extension DonatorVC {
  func setupItemNameTextFieldPlaceholder() {
    itemNameTextField.setupPlaceholderDesign(title: .enterYourDonationName, color: .middleBlue)
  }
}

//MARK: - Setup little bar view design
extension DonatorVC {
  func setupLittleBarViewDesign() {
    littleBarView.backgroundColor = UIColor.mainBlue
  }
}

//MARK: - Setup item description background view design
extension DonatorVC {
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroundView.backgroundColor = UIColor.iceBackground
    itemDescriptionBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroundView.layer.borderWidth = 1
    itemDescriptionBackgroundView.layer.cornerRadius = 10
  }
}

//MARK: - Setup map kit view view design
extension DonatorVC {
  func setupMapView() {
    mapView.layer.cornerRadius = 10
  }
}

//MARK: - Setup reset and make donation button design
extension DonatorVC {
  func setupResetAndDonateButton() {
    resetAndDonateButton[0].commonDesign(title: .reset, shadowWidth: 0, shadowHeight: -2)
    resetAndDonateButton[1].commonDesign(title: .makeADonation, shadowWidth: 0, shadowHeight: 2)
    for button in resetAndDonateButton {
      button.backgroundColor = UIColor.mainBlue
      button.setTitleColor(UIColor.lightBlue, for: .normal)
    }
  }
}

//MARK: - Setup description item text view design with a placeholder
extension DonatorVC: UITextViewDelegate {
  func setupItemDescriptionTextView() {
    itemDescriptionTextView.setupPlaceholderDesign(placeholderText: .enterItemDescription)
  }
  
  // Custom font shows up when user start editing
  func textViewDidBeginEditing(_ textView: UITextView) {
    if itemDescriptionTextView.textColor == UIColor.middleBlue {
      itemDescriptionTextView.text = ""
      itemDescriptionTextView.backgroundColor = UIColor.iceBackground
      itemDescriptionTextView.textColor = UIColor.typoBlue
      itemDescriptionTextView.font = UIFont(customFont: .arialBold, withSize: .seventeen)
    }
    // To avoid buttons action on tap gesture to dismiss keyboard
    resetAndDonateButton[0].isEnabled = false
    mapKitButton.isEnabled = false
    itemDatePicker.isEnabled = false
  }
  
  // Placeholder comes back when text view is empty
  func textViewDidEndEditing(_ textView: UITextView) {
    if itemDescriptionTextView.text == "" {
      itemDescriptionTextView.setupPlaceholderDesign(placeholderText: .enterItemDescription)
    }
    // Put button back to normal after tap gesture dismiss keyboard
    resetAndDonateButton[0].isEnabled = true
    mapKitButton.isEnabled = true
    itemDatePicker.isEnabled = true
  }
}

//MARK: - Setup Tap gesture recognizer to dismiss keyboard
extension DonatorVC {
  func hideKeyboardOnTapGesture() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboardOnTap() {
    view.endEditing(true)
  }
}

//MARK: - Handle to show hidden text view
extension DonatorVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardFrame = keyboardSize.cgRectValue
    guard itemDescriptionTextView.isFirstResponder else { return }
    guard view.frame.origin.y == 0 else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y -= (keyboardFrame.height / 2)
    }
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    guard view.frame.origin.y != 0 else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y = 0
    }
  }
}
