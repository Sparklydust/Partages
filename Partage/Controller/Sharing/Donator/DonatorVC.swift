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
  @IBOutlet weak var itemImage: UIImageView!
  @IBOutlet weak var addItemImageButton: UIButton!
  @IBOutlet weak var mapKitButton: UIButton!
  @IBOutlet weak var resetButton: UIButton!
  @IBOutlet weak var makeDonationButton: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var underlineView: UIView!
  @IBOutlet weak var itemDescriptionBackgroundView: UIView!
  
  var keyboardFrame: CGRect = .zero
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    observeKeyboardNotification()
    hideKeyboardOnTapGesture()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Buttons actions
extension DonatorVC {
  //MARK: Add item image button action
  @IBAction func addItemImageButtonAction(_ sender: Any) {
    view.endEditing(true)
  }
  
  //MARK: Map kit button action
  @IBAction func mapKitButtonAction(_ sender: Any) {
  }
  
  //MARK: Reset Button Action
  @IBAction func resetButtonAction(_ sender: Any) {
  }
  
  //MARK: Make a donation button action
  @IBAction func makeADonationButtonAction(_ sender: Any) {
  }
}

//MARK: - Main setup
extension DonatorVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupResetAndDonateButton()
    setupItemNameTextField()
    setupItemNameTextFieldPlaceholder()
    setupUnderlineView()
    setupItemDescriptionTextViewPlacehoder()
    setupItemDescriptionBackgroundView()
    setupMapView()
    setupItemImage()
    setupItemPicker()
    setupDatePicker()
    setupNavigationController()
    setupSwipeGesture()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
  
  //MARK: All delegates
  func setupAllDelegates() {
    itemTypePickerView.delegate = self
    itemTypePickerView.dataSource = self
    itemDescriptionTextView.delegate = self
    itemNameTextField.delegate = self
  }
}

//MARK: - Setup item type picker view design data
extension DonatorVC: UIPickerViewDelegate, UIPickerViewDataSource {
  func setupItemPicker() {
    itemTypePickerView.backgroundColor = .iceBackground
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
  
  // Change picker view item text color
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let titleData = DonatorItem.type[row].rawValue
    let myTitles = NSAttributedString(string: titleData, attributes: [
      NSAttributedString.Key.foregroundColor: UIColor.typoBlue])
    return myTitles
  }
}

//MARK: - Setup date picker design
extension DonatorVC {
  func setupDatePicker() {
    itemDatePicker.backgroundColor = .iceBackground
    itemDatePicker.setValue(UIColor.typoBlue, forKey: Key.pickerTextColor.rawValue)
  }
}

//MARK: - Setup item name text field design
extension DonatorVC {
  func setupItemNameTextField() {
    itemNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: .typoBlue)
    itemNameTextField.setupMainBackgroundColor()
  }
}

//MARK: - Setup item text field placeholder
extension DonatorVC {
  func setupItemNameTextFieldPlaceholder() {
    itemNameTextField.setupPlaceholderDesign(title: .enterYourDonationName, color: .middleBlue)
  }
}

//MARK: - Setup underline view design
extension DonatorVC {
  func setupUnderlineView() {
    underlineView.backgroundColor = .mainBlue
  }
}

//MARK: - Setup item description background view design
extension DonatorVC {
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroundView.backgroundColor = .iceBackground
    itemDescriptionBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroundView.layer.borderWidth = 1
    itemDescriptionBackgroundView.layer.cornerRadius = 10
  }
}

//MARK: - Setup map kit view design
extension DonatorVC {
  func setupMapView() {
    mapView.layer.cornerRadius = 10
  }
}

//MARK: - Setup reset and make donation button design
extension DonatorVC {
  func setupResetAndDonateButton() {
    resetButton.commonDesign(title: .reset)
    makeDonationButton.commonDesign(title: .makeADonation)
  }
}

//MARK: - Setup item image design
extension DonatorVC {
  func setupItemImage() {
    itemImage.layer.cornerRadius = 1
  }
}

//MARK: - Setup navigation controller design
extension DonatorVC {
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup item name text field design and actions
extension DonatorVC: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    actionsAreEnable(false)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    actionsAreEnable(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    itemNameTextField.resignFirstResponder()
    return true
  }
}

//MARK: - Setup item description text view design with a placeholder and actions
extension DonatorVC: UITextViewDelegate {
  func setupItemDescriptionTextViewPlacehoder() {
    itemDescriptionTextView.setupPlaceholderDesign(placeholderText: .enterItemDescription)
  }
  
  // Custom font shows up when user start editing
  func textViewDidBeginEditing(_ textView: UITextView) {
    if itemDescriptionTextView.textColor == .middleBlue {
      itemDescriptionTextView.text = ""
      itemDescriptionTextView.backgroundColor = .iceBackground
      itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: .typoBlue)
    }
    actionsAreEnable(false)
    resizeViewWhenKeyboardShows()
  }
  
  // Placeholder comes back when text view is empty
  func textViewDidEndEditing(_ textView: UITextView) {
    if itemDescriptionTextView.text == "" {
      itemDescriptionTextView.setupPlaceholderDesign(placeholderText: .enterItemDescription)
    }
    actionsAreEnable(true)
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

//MARK: - Setup swipe gesture to dismiss keyboard
extension DonatorVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    view.endEditing(true)
  }
  
  func setupSwipeGesture() {
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeDown)
  }
}

//MARK: - Handler to show hidden text view
extension DonatorVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    keyboardFrame = keyboardSize.cgRectValue
    resizeViewWhenKeyboardShows()
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    keyboardFrame = .zero
    resizeViewWhenKeyboardHides()
  }
  
  func resizeViewWhenKeyboardShows() {
    guard itemDescriptionTextView.isFirstResponder else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y -= (self.keyboardFrame.height / 2) - self.navigationController!.navigationBar.frame.size.height
    }
  }
  
  func resizeViewWhenKeyboardHides() {
    guard view.frame.origin.y != .zero else { return }
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y = self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
    }
  }
}

//MARK: - Enable or disable actions when tap gesture is enabled
extension DonatorVC {
  func actionsAreEnable(_ action: Bool) {
    resetButton.isEnabled = action
    mapKitButton.isEnabled = action
    itemDatePicker.isEnabled = action
    itemTypePickerView.isUserInteractionEnabled = action
  }
}
