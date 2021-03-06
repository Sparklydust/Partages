//
//  DonorVC.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MapKit

class DonorVC: UIViewController {

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

  var address: Address?
  var images = [UIImage]()
  var pickupDateAndTime: Date!

  var itemToEdit: DonatedItem?
  var latitudeToSet: Double?
  var longitudeToSet: Double?

  var buttonName: ButtonName?
  var authToDisplayGoogleAd = false

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    observeKeyboardNotification()
    hideKeyboardOnTapGesture()
    populateItemToEditFromItemDetailsVC()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(false)
    hideNavigationBarWhenMovingFromParent()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

//MARK: - Buttons actions
extension DonorVC {
  //MARK: Add item image button action
  @IBAction func addItemImageButtonAction(_ sender: Any) {
    dismissKeyboard()
    performSegue(withIdentifier: Segue.goToItemImagesVC.rawValue, sender: self)
  }

  //MARK: Map kit button action
  @IBAction func mapKitButtonAction(_ sender: Any) {
    dismissKeyboard()
    performSegue(withIdentifier: Segue.goToMapViewVC.rawValue, sender: self)
  }

  //MARK: Reset Button Action
  @IBAction func resetButtonAction(_ sender: Any) {
    allEntriesBackToOriginStateWithAlert()
  }

  //MARK: Make a donation button action
  @IBAction func makeADonationButtonAction(_ sender: Any) {
    dismissKeyboard()
    guard UserDefaultsService.shared.userToken != nil else {
      showAlert(title: .restrictedTitle, message: .notConnected, buttonName: .ok) { (true) in
        self.performSegue(withIdentifier: Segue.goToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
    guard itemToEdit?.id == nil else {
      updateDonatedItem()
      return
    }
    createDonorItemAndSaveItIntoDatabase()
  }
}

//MARK: - Main setup
extension DonorVC {
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

//MARK: - Picker view design data
extension DonorVC: UIPickerViewDelegate, UIPickerViewDataSource {
  func setupItemPicker() {
    itemTypePickerView.backgroundColor = .iceBackgroundDarkMode
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(
    _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return DonatedItem.type.count
  }

  func pickerView(
    _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return DonatedItem.type[row].description
  }

  // Change picker view item text color
  func pickerView(
    _ pickerView: UIPickerView,
    attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let titleData = DonatedItem.type[row].description
    let myTitles = NSAttributedString(string: titleData, attributes: [
      NSAttributedString.Key.foregroundColor: UIColor.typoBlueDarkMode as Any])
    return myTitles
  }
}

//MARK: - Design setup
extension DonorVC {
  //MARK: Setup date picker design
  func setupDatePicker() {
    itemDatePicker.backgroundColor = .iceBackgroundDarkMode
    itemDatePicker.setValue(UIColor.typoBlueDarkMode, forKey: Key.pickerTextColor.description)
  }

  //MARK: Setup item name text field design
  func setupItemNameTextField() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemNameTextField.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
    }
    itemNameTextField.setupMainBackgroundColor()
  }

  //MARK: Setup item text field placeholder
  func setupItemNameTextFieldPlaceholder() {
    itemNameTextField.setupPlaceholderDesign(title: .enterYourDonationName, color: .middleBlue)
  }

  //MARK: Setup underline view design
  func setupUnderlineView() {
    underlineView.backgroundColor = .mainBlue
  }

  //MARK: Setup item description background view design
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroundView.backgroundColor = .iceBackgroundDarkMode
    itemDescriptionBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroundView.layer.borderWidth = 1
    itemDescriptionBackgroundView.layer.cornerRadius = 10
  }

  //MARK: Setup reset and make donation button design
  func setupResetAndDonateButton() {
    resetButton.commonDesign(title: .reset)
    makeDonationButton.commonDesign(title: buttonName ?? .makeADonation)
  }

  //MARK: Setup item image design
  func setupItemImage() {
    itemImage.layer.cornerRadius = 3
  }

  //MARK: Setup navigation controller design
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup item name text field design and actions
extension DonorVC: UITextFieldDelegate {
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
extension DonorVC: UITextViewDelegate {
  func setupItemDescriptionTextViewPlacehoder() {
    itemDescriptionTextView.setupPlaceholderDesign(placeholderText: .enterItemDescription)
  }

  // Custom font shows up when user start editing
  func textViewDidBeginEditing(_ textView: UITextView) {
    if itemDescriptionTextView.textColor == .middleBlue {
      itemDescriptionTextView.text = ""
      itemDescriptionTextView.backgroundColor = .iceBackgroundDarkMode
      if let darkModeColor = UIColor.typoBlueDarkMode {
        itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: darkModeColor)
      }
    }
    actionsAreEnable(false)
    resizeViewWhenKeyboardShows()
  }

  // Placeholder comes back when text view is empty
  func textViewDidEndEditing(_ textView: UITextView) {
    actionsAreEnable(true)
  }
}

//MARK: - Setup map kit view design
extension DonorVC {
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

//MARK: - Setup Tap gesture recognizer to dismiss keyboard
extension DonorVC {
  func hideKeyboardOnTapGesture() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(dismissKeyboardOnTap))
    view.addGestureRecognizer(tap)
  }

  @objc func dismissKeyboardOnTap() {
    dismissKeyboard()
  }
}

//MARK: - Setup swipe gesture to dismiss keyboard
extension DonorVC {
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
extension DonorVC {
  func allEntriesBackToOriginStateWithAlert() {
    showAlert(title: .resetTitle, message: .resetDonation, buttonName: .reset) { (true) in
      self.clearAllEntries()
    }
  }

  func allEntriesBackToOriginStateWithoutAlert() {
    clearAllEntries()
  }

  func clearAllEntries() {
    itemTypePickerView.selectRow(0, inComponent: 0, animated: true)
    itemDatePicker.setDate(Date.init(), animated: true)
    itemNameTextField.text = ""
    itemDescriptionTextView.text = ""
    itemImage.image = nil
    setupMapView()
  }
}

//MARK: - Handler to show hidden text view
extension DonorVC {
  func observeKeyboardNotification() {
    let center: NotificationCenter = NotificationCenter.default
    center.addObserver(self, selector: #selector(keyboardWillShow),
                       name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: #selector(keyboardWillHide),
                       name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = notification
      .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
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
      self.view.frame.origin.y -= (
        self.keyboardFrame.height / 2) - self.navigationController!.navigationBar.frame.size.height
    }
  }

  func resizeViewWhenKeyboardHides() {
    guard view.frame.origin.y != .zero else { return }
    let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    UIView.animate(withDuration: 0.4) {
      self.view.frame.origin.y = (
        self.navigationController?.navigationBar.frame.size.height ?? 0.0) + height
    }
  }
}

//MARK: - Enable or disable actions when tap gesture is enabled
extension DonorVC {
  func actionsAreEnable(_ action: Bool) {
    resetButton.isEnabled = action
    mapKitButton.isEnabled = action
    itemDatePicker.isEnabled = action
    itemTypePickerView.isUserInteractionEnabled = action
  }
}

//MARK: - Item address receiver from MapViewVC
extension DonorVC: CanReceiveItemAddressDelegate {
  func addressReceived(coordinates: CLLocation,
                       streetNumber: String,
                       streetName: String,
                       postalCode: String,
                       cityName: String,
                       countryName: String) {
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
extension DonorVC: CanReceiveItemImagesDelegate {
  func imagesReceived(image: [UIImage]) {
    images = image
    itemImage.image = image[0]
  }
}

//MARK: - Unwind to VCs methods
extension DonorVC {
  func unwindToSharingVC() {
    self.performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
  }

  func unwindToHistoryFavoriteVC() {
    self.performSegue(withIdentifier: Segue.unwindToHistoryFavoriteVC.rawValue, sender: self)
  }

  func unwindToSignInVC() {
    performSegue(withIdentifier: Segue.unwindToSignInVC.rawValue, sender: self)
  }
}

//MARK: - Mthod to check if all fields are filled when user makes or update his donation
extension DonorVC {
  func checkAllFieldsAreFilledBeforeNetworking(
    _ donatedItem: DonatedItem, completion: @escaping () -> ()) {
    switch true {
    case donatedItem.selectedType == DonorItemType.selectItem.description:
      showAlert(title: .emptyCaseTitle, message: .noItemTypeSelected)
      break
    case donatedItem.name.isEmpty:
      showAlert(title: .emptyCaseTitle, message: .noItemName)
      break
    case images == [UIImage]():
      showAlert(title: .emptyCaseTitle, message: .noImage)
      break
    case pickupDateAndTime.isLessThanDate(dateToCompare: Date()) ||
      pickupDateAndTime.equalToDate(dateToCompare: Date()):
      showAlert(title: .emptyCaseTitle, message: .noItemDate)
      break
    case donatedItem.latitude == .zero && donatedItem.longitude == .zero:
      showAlert(title: .emptyCaseTitle, message: .noMeetingPoint)
      break
    case donatedItem.description == StaticLabel.enterItemDescription.description ||
      donatedItem.description == "":
      showAlert(title: .emptyCaseTitle, message: .noDescription)
      break
    default:
      completion()
    }
  }
}

//MARK: - Prepare for segue
extension DonorVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goToItemImagesVC.rawValue {
      let secondVC = segue.destination as! ItemImagesVC
      secondVC.delegate = self
      if let item = itemToEdit {
        secondVC.donorItem = item
      }
    }
    else if segue.identifier == Segue.goToMapViewVC.rawValue {
      let secondVC = segue.destination as! MapViewVC
      secondVC.delegate = self
    }
    else if segue.identifier == Segue.unwindToSharingVC.rawValue {
      let secondVC = segue.destination as! SharingVC
      secondVC.displayAd = authToDisplayGoogleAd
    }
  }
}

//MARK: - API calls
extension DonorVC {
  //MARK: Creation of the donator item and saving it into database if all fields are filled
  func createDonorItemAndSaveItIntoDatabase() {
    pickupDateAndTime = itemDatePicker.date
    let dateAndTime = ISO8601DateFormatter.string(
      from: pickupDateAndTime, timeZone: .current, formatOptions: .withInternetDateTime)

    let donatedItem = DonatedItem(
      isPicked: false,
      selectedType: DonatedItem.type[itemTypePickerView.selectedRow(inComponent: 0)].description,
      name: itemNameTextField.text!,
      pickUpDateTime: dateAndTime,
      description: itemDescriptionTextView.text!,
      latitude: address?.latitude ?? .zero,
      longitude: address?.longitude ?? .zero
    )
    checkAllFieldsAreFilledBeforeNetworking(donatedItem) {
      self.showAlert(title: .thankYouTitle, message: .confirmDonation, buttonName: .confirm) {
        (true) in
        let resourcePath = NetworkPath.donatedItems.description
        ResourceRequest<DonatedItem>(resourcePath).save(donatedItem, tokenNeeded: true, { [weak self] (result) in
          switch result {
          case .failure:
            DispatchQueue.main.async { [weak self] in
              self?.showAlert(title: .errorTitle, message: .networkRequestError)
            }
          case .success:
            DispatchQueue.main.async { [weak self] in
              if let imageToSave = self?.images[0] {
                FirebaseStorageHandler.shared.upload(imageToSave, of: donatedItem)
              }
              self?.authToDisplayGoogleAd = true
              self?.unwindToSharingVC()
              self?.allEntriesBackToOriginStateWithoutAlert()
            }
          }
        })
      }
    }
  }

  //MARK: Donor update item from itemDetailsVC edit button
  func updateDonatedItem() {
    guard let donatedItemID = itemToEdit?.id else { return }
    
    if let image = itemImage.image {
      images.append(image)
    }
    pickupDateAndTime = itemDatePicker.date
    let dateAndTime = ISO8601DateFormatter.string(
      from: pickupDateAndTime, timeZone: .current, formatOptions: .withInternetDateTime)
    
    if address?.latitude == nil {
      latitudeToSet = itemToEdit?.latitude
      longitudeToSet = itemToEdit?.longitude
    }
    else {
      latitudeToSet = address?.latitude
      longitudeToSet = address?.longitude
    }

    var updatedItem = DonatedItem(
      isPicked: itemToEdit!.isPicked,
      selectedType: DonatedItem.type[itemTypePickerView.selectedRow(inComponent: 0)].description,
      name: itemNameTextField.text!,
      pickUpDateTime: dateAndTime,
      description: itemDescriptionTextView.text!,
      latitude: latitudeToSet ?? .zero,
      longitude: longitudeToSet ?? .zero
    )
    checkAllFieldsAreFilledBeforeNetworking(updatedItem) {
      self.showAlert(title: .thankYouTitle, message: .confirmChanges, buttonName: .confirm) {
        (true) in
        
        let resourcePath = NetworkPath.donatedItems.description + "\(donatedItemID)"
        ResourceRequest<DonatedItem>(resourcePath).update(updatedItem, tokenNeeded: true, { (result) in
          switch result {
          case .failure:
            DispatchQueue.main.async { [weak self] in
              self?.showAlert(title: .errorTitle, message: .networkRequestError)
            }
          case .success(let item):
            DispatchQueue.main.async { [weak self] in
              updatedItem = item
              if let imageToSave = self?.images[0] {
                FirebaseStorageHandler.shared.upload(imageToSave, of: updatedItem)
              }
              self?.unwindToHistoryFavoriteVC()
              self?.allEntriesBackToOriginStateWithoutAlert()
            }
          }
        })
      }
    }
  }
}

//MARK: - Populate item to update when donor wants to make changes from ItemDetailsVC
extension DonorVC {
  func populateItemToEditFromItemDetailsVC() {
    guard itemToEdit?.id != nil else { return }
    populateItemTypePicker()
    populateItemDatePicker()
    itemNameTextField.text = itemToEdit?.name
    mapKitButton.setTitle(ButtonName.changeMeetingPoint.description, for: .normal)
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: darkModeColor)
    }
    itemDescriptionTextView.text = itemToEdit?.description
    if let item = itemToEdit {
      FirebaseStorageHandler.shared.downloadItemImage(of: item, into: itemImage)
    }
  }

  //Show the picker item type the way the item is
  func populateItemTypePicker() {
    for type in DonatedItem.type {
      if type.description == itemToEdit?.selectedType {
        guard let index = DonatedItem.type.firstIndex(of: type) else { return }
        itemTypePickerView.selectRow(index, inComponent: 0, animated: true)
      }
    }
  }

  //Show the date picker from the item date
  func populateItemDatePicker() {
    guard let isoDateString = itemToEdit?.pickUpDateTime else { return }
    let trimmedIsoString = (isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression))
    guard let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString) else { return }
    itemDatePicker.setDate(dateAndTime, animated: true)
  }
}

//MARK: - Hide Navigation bar when view controller dismiss
extension DonorVC {
  func hideNavigationBarWhenMovingFromParent() {
    if self.isMovingFromParent {
      guard self.navigationController?.viewControllers.previous is SharingVC else { return }
      navigationController?.setNavigationBarHidden(true, animated: true)
    }
  }
}
