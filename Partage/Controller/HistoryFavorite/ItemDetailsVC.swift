//
//  ItemDetailsVC.swift
//  Partage
//
//  Created by Roland Lariotte on 07/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MapKit

class ItemDetailsVC: UIViewController {

  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var donorReceiverNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var underlineView: UIView!
  @IBOutlet weak var itemDescriptionBackgroudView: UIView!
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  @IBOutlet weak var donorReceiverProfileImage: UIImageView!
  @IBOutlet weak var itemImage: UIImageView!
  @IBOutlet weak var addToCalendarButton: UIButton!
  @IBOutlet weak var messageToButton: UIButton!
  @IBOutlet weak var itemPictureButton: UIButton!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var addToCalendarActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var messageToActivityIndicator: UIActivityIndicatorView!

  @IBOutlet var staticItemDetailsLabels: [UILabel]!

  var messageTobuttonName: ButtonName!

  var itemDetails: DonatedItem!
  var calendarTitle = String()
  var address = String()

  var messages = [Message]()
  var senderID = String()

  var firstUserID = String()
  var secondUserID = String()

  var receiver: User? {
    didSet {
      populateReceiver()
    }
  }

  var donor: User? {
    didSet {
      populateDonor()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupVCInfoFrom(itemDetails)
    getTheMeetingPointAddress(latitude: itemDetails.latitude, longitude: itemDetails.longitude)
    infoToHideOrShowDependingOfUser()
    fetchUsersFromTheDatabase()
    setupUserIDToSenderIDVariable()
    hideAllActivityIndicators()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    donorReceiverProfileImage.roundedWithMainBlueBorder()
  }
}

//MARK: - Buttons actions
extension ItemDetailsVC {
  //MARK: Item picture button action
  @IBAction func itemPictureButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToItemImagesVC.rawValue, sender: self)
  }

  //MARK: Map kit view button action
  @IBAction func mapKitButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToMapViewVC.rawValue, sender: self)
  }

  //MARK: Add to calendar button action
  @IBAction func addToCalendarButtonAction(_ sender: Any) {
    guard itemDetails.isPicked else {
      userPicksUpADonatedItem()
      return
    }
    addItemToCalendar()
  }

  //MARK: Message to receiver or donator button action
  @IBAction func messageToButtonAction(_ sender: Any) {
    CheckUsersAlreadyCommunicateBeforeCreatingMessage()
  }

  //MARK: Edit donation button action
  @IBAction func editButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToDonatorVC.rawValue, sender: self)
  }
}

//MARK: - Main setup
extension ItemDetailsVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupOutletsCollectionsOrder()
    setupMainView()
    setupMainLabels()
    setupStaticItemDetailsLabels()
    setupUnderlineViewBackgroundColor()
    setupAddToCalendarAndMessageButton()
    setupItemDescriptionTextView()
    setupMapView()
    setupEditButton()
    setupItemImage()
    populateItemImageFromFirebaseStorage()
  }

  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Design setup
extension ItemDetailsVC {
  //MARK: Setup main labels design
  func setupMainLabels() {
    itemNameLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .typoBlue)
    donorReceiverNameLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
    dateLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
    timeLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
  }

  //MARK: Setup outlet collection to be in order
  func setupOutletsCollectionsOrder() {
    staticItemDetailsLabels = staticItemDetailsLabels.sorted(by: { $0.tag < $1.tag })
  }

  //MARK: Setup all static Labels design
  func setupStaticItemDetailsLabels() {
    staticLabelReceiverOrDonor()
    staticItemDetailsLabels[1].text = StaticItemDetail.the.description
    staticItemDetailsLabels[2].text = StaticItemDetail.at.description
    staticItemDetailsLabels[3].text = StaticItemDetail.address.description
    for label in staticItemDetailsLabels {
      label.setupFont(as: .arial, sized: .seventeen, in: .typoBlue)
    }
  }

  //MARK: Setup underline view background color design
  func setupUnderlineViewBackgroundColor() {
    underlineView.setupBackgroundColorIn(.mainBlue)
  }

  //MARK: Setup item description text view design
  func setupItemDescriptionTextView() {
    itemDescriptionTextView.isEditable = false
    itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: .typoBlue)
    setupItemDescriptionBackgroundView()
  }

  //MARK: Setup item description background view design
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroudView.layer.cornerRadius = 10
    itemDescriptionBackgroudView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroudView.layer.borderWidth = 1
  }

  //MARK: Setup map kit view view design
  func setupMapView() {
    mapView.layer.cornerRadius = 10
  }

  //MARK: Setup edit button design
  func setupEditButton() {
    editButton.editButtonDesign()
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

//MARK: - Setup add to Calendar and message button design
extension ItemDetailsVC {
  func setupAddToCalendarAndMessageButton() {
    buttonsNameReceiverOrDonor()
    addToCalendarButtonDesignIfItemPickedOrNot()
  }

  func addToCalendarButtonDesignIfItemPickedOrNot() {
    guard itemDetails.isPicked else {
      addToCalendarButton.commonDesign(title: .receiveThisDonation)
      return
    }
    addToCalendarButton.commonDesign(title: .addToCalendar)
  }
}

//MARK: - Setup depending on receiver or donator
extension ItemDetailsVC {
  func buttonsNameReceiverOrDonor() {
    guard UserDefaultsService.shared.userID == itemDetails.receiverID || !itemDetails.isPicked else {
      messageToButton.commonDesign(title: .messageToReceiver)
      messageTobuttonName = .messageToReceiver
      return
    }
    messageToButton.commonDesign(title: .messageToDonor)
    messageTobuttonName = .messageToDonor
  }

  func staticLabelReceiverOrDonor() {
    guard UserDefaultsService.shared.userID == itemDetails.receiverID else {
      staticItemDetailsLabels[0].text = StaticItemDetail.receiveDonation.description
      return
    }
    staticItemDetailsLabels[0].text = StaticItemDetail.giveDonation.description
  }
}

//MARK: - Setup userID into senderID varirable
extension ItemDetailsVC {
  func setupUserIDToSenderIDVariable() {
    if let id = UserDefaultsService.shared.userID {
      senderID = id
    }
  }
}

//MARK: - Populate donated item info
extension ItemDetailsVC {
  func setupVCInfoFrom(_ donorItem: DonatedItem) {
    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    let date = dateAndTime?.asString(style: .short)
    let time = dateAndTime?.asString()

    itemNameLabel.text = donorItem.name
    dateLabel.text = date
    timeLabel.text = time
    LocationHandler.shared.itemAnnotationShown(
      on: mapView, latitude: donorItem.latitude, longitude: donorItem.longitude)
    itemDescriptionTextView.text = donorItem.description
  }
}

//MARK: - Get the meeting point address for add to calendar button
extension ItemDetailsVC {
  func getTheMeetingPointAddress(latitude: Double , longitude: Double) {
    let meetingPoint = CLLocation.init(latitude: latitude, longitude: longitude)

    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(meetingPoint) { [weak self]
      (placemarks, error) in
      guard self != nil else { return }
      if let _ =  error {
        self?.showAlert(title: .errorTitle, message: .locationIssue)
        return
      }
      guard let placemark = placemarks?.first else {
        self?.showAlert(title: .errorTitle, message: .locationIssue)
        return
      }
      let streetNumber = placemark.subThoroughfare ?? ""
      let streetName = placemark.thoroughfare ?? ""
      let postalCode = placemark.postalCode ?? ""
      let cityName = placemark.locality ?? ""
      let countryName = placemark.country ?? ""
      
      DispatchQueue.main.async { [weak self] in
        self?.address =
        "\(streetNumber) \(streetName) \(postalCode) \(cityName), \(countryName.uppercased())"
      }
    }
  }
}

//MARK: - Method to add the detailed item in the user calendar as en event
extension ItemDetailsVC {
  func addItemToCalendar() {
    triggerAddToCalendarActivityIndicator(true)
    let isoDateString = itemDetails.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    if UserDefaultsService.shared.userID == itemDetails.receiverID {
      calendarTitle = StaticLabel.receiverCalendarTitle.description + itemDetails.name
    }
    else {
      calendarTitle = StaticLabel.donorCalendarTitle.description + itemDetails.name
    }
    guard let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString) else { return }
    EventHandler.shared.addEventToCalendar(
      vc: self, title: calendarTitle, location: address, startDate: dateAndTime, notes: itemDetails.description)
    triggerAddToCalendarActivityIndicator(false)
  }
}

//MARK: - Activity Indicator action and setup
extension ItemDetailsVC {
  func triggerMessageToActivityIndicator(_ action: Bool) {
    triggerActivityIndicator(action, on: messageToActivityIndicator, as: messageToButton, named: messageTobuttonName)
  }

  func triggerAddToCalendarActivityIndicator(_ action: Bool) {
    triggerActivityIndicator(action, on: addToCalendarActivityIndicator, as: addToCalendarButton, named: .addToCalendar)
  }

  func triggerActivityIndicator(
    _ action: Bool, on activityIndicator: UIActivityIndicatorView, as button: UIButton, named name: ButtonName) {
    guard action else {
      hideActivityIndicator(activityIndicator, button, name)
      return
    }
    showActivityIndicator(activityIndicator, button)
  }

  func showActivityIndicator(_ activityIndicator: UIActivityIndicatorView, _ button: UIButton) {
    activityIndicator.isHidden = false
    activityIndicator.style = .whiteLarge
    activityIndicator.color = .iceBackground
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    button.commonDesign(title: .emptyString)
    button.isHidden = false
  }

  func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView, _ button: UIButton, _ name: ButtonName) {
    activityIndicator.isHidden = true
    button.commonDesign(title: name)
  }

  func hideAllActivityIndicators() {
    triggerActivityIndicator(false, on: messageToActivityIndicator, as: messageToButton, named: messageTobuttonName)
    triggerActivityIndicator(false, on: addToCalendarActivityIndicator, as: addToCalendarButton, named: .addToCalendar)
  }
}

//MARK: - Populate info depending of whom is the donor or receiver
extension ItemDetailsVC {
  func infoToHideOrShowDependingOfUser() {
    guard itemDetails.isPicked else {
      hideUserInfoAndStaticLabel()
      showEditButton()
      return
    }
    if messageToButton.titleLabel?.text == ButtonName.messageToDonor.description {
      hideEditButton()
    }
    else {
      showEditButton()
    }
  }

  func populateReceiver() {
    guard let firstName = receiver?.firstName else { return }
    if messageToButton.titleLabel?.text == ButtonName.messageToReceiver.description {
      donorReceiverNameLabel.text = firstName
      guard let receiverID = receiver?.id?.uuidString else { return }
      FirebaseStorageHandler.shared.downloadProfilePicture(of: receiverID, into: donorReceiverProfileImage)
    }
    if let anotherUserID = self.receiver?.id?.uuidString {
      self.secondUserID = anotherUserID
    }
  }

  func populateDonor() {
    guard let firstName = donor?.firstName else { return }
    if messageToButton.titleLabel?.text == ButtonName.messageToDonor.description {
      donorReceiverNameLabel.text = firstName
      guard let donorID = donor?.id?.uuidString else { return }
      FirebaseStorageHandler.shared.downloadProfilePicture(of: donorID, into: donorReceiverProfileImage)
    }
    if let oneUserID = self.donor?.id?.uuidString {
      self.firstUserID = oneUserID
    }
    guard donor?.id?.uuidString == UserDefaultsService.shared.userID && !itemDetails.isPicked else { return }
    addToCalendarButton.isHidden = true
    messageToButton.isHidden = true
  }
}

//MARK: - Show or hide edit button methods
extension ItemDetailsVC {
  func showEditButton() {
    editButton.title = ButtonName.edit.description
    editButton.isEnabled = true
  }

  func hideEditButton() {
    editButton.title = StaticLabel.emptyString.description
    editButton.isEnabled = false
  }
}

//MARK: - Hide user info and a specific static label when needed
extension ItemDetailsVC {
  func hideUserInfoAndStaticLabel() {
    donorReceiverNameLabel.isHidden = true
    donorReceiverProfileImage.isHidden = true
    staticItemDetailsLabels[0].isHidden = true
  }
}

//MARK: - Fetch donor and receiver from the database
extension ItemDetailsVC {
  func fetchUsersFromTheDatabase() {
    fetchReceiverFromTheDatabase()
    fetchDonorFromTheDatabase()
  }
}

//MARK: - Prepare for segue
extension ItemDetailsVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goToMapViewVC.rawValue {
      let destinationVC = segue.destination as! MapViewVC
      destinationVC.donorItemLatitude = itemDetails.latitude
      destinationVC.donorItemLongitude = itemDetails.longitude
      destinationVC.buttonName = .openMapApp
    }
    else if segue.identifier == Segue.goToDonatorVC.rawValue {
      let destinationVC = segue.destination as? DonorVC
      destinationVC?.itemToEdit = itemDetails
      destinationVC?.buttonName = .modifyDonation
    }
    else if segue.identifier == Segue.unwindToMessageVC.rawValue {
      let destinationVC = segue.destination as? MessageVC
      destinationVC?.firstUserID = firstUserID
      destinationVC?.secondUserID = secondUserID
    }
    else if segue.identifier == Segue.goToItemImagesVC.rawValue {
      let destinationVC = segue.destination as? ItemImagesVC
      destinationVC?.isReceiver = true
      destinationVC?.donorItem = itemDetails
    }
  }
}

//MARK: - API calls
extension ItemDetailsVC {
  //MARK: Fetch the receiver from the database to get users info
  func fetchReceiverFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let receiverID = itemDetails.receiverID else { return }

    let resourcePath = NetworkPath.users.description + receiverID
    ResourceRequest<User>(resourcePath).get(tokenNeeded: true) { [weak self] (result) in
      switch result {
      case .failure:
        return
      case .success(let user):
        DispatchQueue.main.async { [weak self] in
          self?.receiver = user
        }
      }
    }
  }

  //MARK: Fetch donor from the database
  func fetchDonorFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let itemID = itemDetails.id else { return }
    
    let resourcePath = NetworkPath.donatedItems.description + "\(itemID)/" + "user"
    ResourceRequest<User>(resourcePath).get(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success(let user):
        DispatchQueue.main.async { [weak self] in
          self?.donor = user
        }
      }
    }
  }

  //MARK: User picks up a donated item and save it in the database
  func userPicksUpADonatedItem() {
    guard let donatedItemID = itemDetails.id else { return }
    guard let receiverID = UserDefaultsService.shared.userID else { return }
    guard var updatedDonatedItem = itemDetails else { return }
    guard !updatedDonatedItem.isPicked else {
      showAlert(title: .itemUnselectableTitle, message: .itemAlreadySelected)
      return
    }
    updatedDonatedItem.receiverID = receiverID
    updatedDonatedItem.isPicked = true

    showAlert(title: .itemSelectedTitle, message: .confirmSelection, buttonName: .confirm, completion: { (true) in

      let resourcePath = NetworkPath.donatedItems.description + "\(donatedItemID)"
      ResourceRequest<DonatedItem>(resourcePath).update(updatedDonatedItem, tokenNeeded: true, { (result) in
        switch result {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: .errorTitle, message: .networkRequestError)
          }
        case .success(let pickedUpItem):
          DispatchQueue.main.async { [weak self] in
            updatedDonatedItem = pickedUpItem
            self?.showAlert(title: .successTitle, message: .donatedItemSelected, completion: { (true) in
              self?.performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
            })
          }
        }
      })
    })
  }

  //MARK: User send a message to another user
  func createMessageBetweenTwoUser() {
    guard UserDefaultsService.shared.userID != nil else { return }
     let dateAndTime = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)

    var recipientID = String()
    if senderID == donor?.id?.uuidString {
      recipientID = (receiver?.id?.uuidString)!
    }
    else {
      recipientID = (donor?.id?.uuidString)!
    }

    let message = Message(senderID: senderID,
                          recipientID: recipientID,
                          date: dateAndTime,
                          isReadBySender: true,
                          isReadByRecipient: false)

    let resourcePath = NetworkPath.messages.description
    ResourceRequest<Message>(resourcePath).save(message, tokenNeeded: true) { [weak self] (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.triggerMessageToActivityIndicator(false)
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success:
        DispatchQueue.main.async { [weak self] in
          self?.performSegue(withIdentifier: Segue.unwindToMessageVC.rawValue, sender: self)
        }
      }
    }
  }

  //MARK: Check if users has already communicated before creating chat or going to existing one
  func CheckUsersAlreadyCommunicateBeforeCreatingMessage() {
    guard UserDefaultsService.shared.userID != nil else { return }
    messages = [Message]()
    let userID = UserDefaultsService.shared.userID
    var userAlreadyCommunicate = false

    let resourcePath = NetworkPath.messages.description + NetworkPath.ofUser.description + userID!
    triggerMessageToActivityIndicator(true)
    ResourceRequest<Message>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.triggerMessageToActivityIndicator(false)
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success(let messages):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.messages.append(contentsOf: messages)
          if messages.isEmpty {
            self.createMessageBetweenTwoUser()
          }
          else {
            //Check if users are already connected
            for message in messages {
              if message.recipientID == self.senderID &&
                (message.senderID == self.firstUserID || message.senderID == self.secondUserID) {
                userAlreadyCommunicate = true
                self.performSegue(withIdentifier: Segue.unwindToMessageVC.rawValue, sender: self)
                break
              }
              else if message.senderID == self.senderID &&
                (message.recipientID == self.firstUserID || message.recipientID == self.secondUserID) {
                userAlreadyCommunicate = true
                self.performSegue(withIdentifier: Segue.unwindToMessageVC.rawValue, sender: self)
                break
              }
            }
            guard userAlreadyCommunicate else {
              self.createMessageBetweenTwoUser()
              return
            }
          }
          self.triggerMessageToActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Populate item image from Firebase storage
extension ItemDetailsVC {
  func populateItemImageFromFirebaseStorage() {
    FirebaseStorageHandler.shared.downloadItemImage(of: itemDetails, into: itemImage)
  }
}
