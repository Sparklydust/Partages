//
//  DonatorVC.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

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
  @IBOutlet weak var viewForScrollView: UIView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  var keyboardFrame: CGRect = .zero
  
  private var rootRef: DatabaseReference!
  
  var address: Address!
  var images = [UIImage]()
  var pickupDateAndTime: Date!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    observeKeyboardNotification()
    hideKeyboardOnTapGesture()
    
    rootRef = Database.database().reference()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Buttons actions
extension DonatorVC {
  //MARK: Add item image button action
  @IBAction func addItemImageButtonAction(_ sender: Any) {
    dismissKeyboard()
    performSegue(withIdentifier: Segue.goesToItemImagesVC.rawValue, sender: self)
  }
  
  //MARK: Map kit button action
  @IBAction func mapKitButtonAction(_ sender: Any) {
    dismissKeyboard()
    performSegue(withIdentifier: Segue.goesToMapViewVC.rawValue, sender: self)
  }
  
  //MARK: Reset Button Action
  @IBAction func resetButtonAction(_ sender: Any) {
    setupAllEntriesBackToOriginState()
  }
  
  //MARK: Make a donation button action
  @IBAction func makeADonationButtonAction(_ sender: Any) {
    createDonatorItemAndSaveItIntoFirebase()
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
    viewForScrollView.setupMainBackgroundColor()
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
    mapView.isHidden = true
    mapKitButton.setupAddMeetingPointButton(named: .setupMeetingPoint)
  }
  
  func mapViewActionsAreDisabled() {
    mapKitButton.setTitle(nil, for: .normal)
    mapView.isHidden = false
    mapView.isZoomEnabled = false
    mapView.isScrollEnabled = false
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
    itemImage.layer.cornerRadius = 3
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
    dismissKeyboard()
  }
}

//MARK: - Setup swipe gesture to dismiss keyboard
extension DonatorVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    dismissKeyboard()
  }
  
  func setupSwipeGesture() {
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeDown)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}

//MARK: - Setup all entries back to their origin state
extension DonatorVC {
  func setupAllEntriesBackToOriginState() {
    showAlert(title: .reset, message: .resetDonation, buttonName: .reset) { (true) in
      self.itemTypePickerView.selectRow(0, inComponent: 0, animated: true)
      self.itemDatePicker.setDate(Date.init(), animated: true)
      self.itemNameTextField.text = ""
      self.itemDescriptionTextView.text = ""
      self.itemImage.image = nil
      self.setupMapView()
    }
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

//MARK: - Prepare for segue methods
extension DonatorVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goesToItemImagesVC.rawValue {
      let secondVC = segue.destination as! ItemImagesVC
      secondVC.delegate = self
    }
    else if segue.identifier == Segue.goesToMapViewVC.rawValue {
      let secondVC = segue.destination as! MapViewVC
      secondVC.delegate = self
    }
  }
}

//MARK: - Item address receiver from MapViewVC
extension DonatorVC: CanReceiveItemAddressDelegate {
  func addressReceived(coordinates: CLLocation, streetNumber: String, streetName: String, postalCode: String, cityName: String, countryName: String) {
    address = Address(
      latitude: coordinates.coordinate.latitude,
      longitude: coordinates.coordinate.longitude,
      streetNumber: streetNumber,
      streetName: streetName,
      postalCode: postalCode,
      city: cityName,
      country: countryName
    )
    mapViewActionsAreDisabled()
    LocationHandler.shared.itemAnnotationShown(on: mapView, located: coordinates.coordinate)
  }
}

//MARK: - Item images receiver from ItemImagesVC
extension DonatorVC: CanReceiveItemImagesDelegate {
  func imagesReceived(image: [UIImage]) {
    images = image
    itemImage.image = image[0]
  }
}

//MARK: - Creation of the donator item and saving it to Firebase database if all fields are filled
extension DonatorVC {
  func createDonatorItemAndSaveItIntoFirebase() {
    pickupDateAndTime = itemDatePicker.date
    let dateAndTime = ISO8601DateFormatter.string(from: pickupDateAndTime, timeZone: .current, formatOptions: .withInternetDateTime)
    
    let donatorItem = DonatorItem(
      selectedType: DonatorItem.type[itemTypePickerView.selectedRow(inComponent: 0)].rawValue,
      name: itemNameTextField.text!,
//      image: images,
      pickupDate: dateAndTime,
      latitude: address.latitude,
      longitude: address.longitude,
      description: itemDescriptionTextView.text!
    )
    switch true {
    case donatorItem.selectedType == DonatorItemType.selectItem.rawValue:
      showAlert(title: .emptyCase, message: .noItemTypeSelected)
      break
    case donatorItem.name == "":
      showAlert(title: .emptyCase, message: .noItemName)
      break
//    case donatorItem.image == [UIImage]():
//      showAlert(title: .emptyCase, message: .noImage)
//      break
    case pickupDateAndTime.isLessThanDate(dateToCompare: Date()) || pickupDateAndTime.equalToDate(dateToCompare: Date()):
      showAlert(title: .emptyCase, message: .noItemDate)
      break
    case donatorItem.latitude == .zero:
      showAlert(title: .emptyCase, message: .noMeetingPoint)
      break
    case donatorItem.description == StaticLabel.enterItemDescription.rawValue || donatorItem.description == "":
      showAlert(title: .emptyCase, message: .noDescription)
      break
    default:
      showAlert(title: .thankYou, message: .confirmDonation, buttonName: .confirm) {
        (true) in
        // Saving donator item to Firebase
        let donatorsItemsRef = self.rootRef.child(FirebaseRoot.donatorsItems.rawValue)
        let itemRef = donatorsItemsRef.childByAutoId()
        itemRef.setValue(donatorItem.toDictionary())
      }
    }
  }
}
