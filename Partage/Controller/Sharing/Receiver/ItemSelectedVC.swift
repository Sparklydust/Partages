//
//  ItemSelectedVC.swift
//  Partage
//
//  Created by Roland Lariotte on 11/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MapKit

class ItemSelectedVC: UIViewController {

  @IBOutlet weak var itemTypeLabel: UILabel!
  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var mapViewButton: UIButton!
  @IBOutlet weak var messageToDonatorButton: UIButton!
  @IBOutlet weak var receiveDonationButton: UIButton!
  @IBOutlet weak var itemImage: UIImageView!
  @IBOutlet weak var itemDescriptionBackgroundView: UIView!
  @IBOutlet weak var underlineView: UIView!
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var messageActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var receiveActivityIndicator: UIActivityIndicatorView!

  @IBOutlet var staticLabels: [UILabel]!

  var donatedItem: DonatedItem!
  var isFavorited = false

  var messages = [Message]()
  var senderID = String()

  var firstUserID = String()
  var secondUserID = String()
  
  var authToDisplayGoogleAd = false

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
    setupVCInfoFrom(donatedItem)
    setupUserIDToSenderIDVariable()
    fetchUsersFromTheDatabase()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    wasRecipeFavorited()
    updateFavoriteButton(isFavorited)
    hideAllActivityIndicators()
  }
}

//MARK: - Buttons actions
extension ItemSelectedVC {
  //MARK: Favorite button action
  @IBAction func favoriteButtonAction(_ sender: Any) {
    guard UserDefaultsService.shared.userToken != nil else {
      showAlert(title: .restrictedTitle, message: .notConnected, buttonName: .ok) { (true) in
        self.performSegue(withIdentifier: Segue.goToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
  }

  //MARK: Item image button action
  @IBAction func itemImageButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToItemImagesVC.rawValue, sender: self)
  }

  //MARK: Map view button action
  @IBAction func mapViewButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goToMapViewVC.rawValue, sender: self)
  }

  //MARK: Messagge to donator button action
  @IBAction func messageToDonatorButtonAction(_ sender: Any) {
    guard UserDefaultsService.shared.userToken != nil else {
      showAlert(title: .restrictedTitle, message: .notConnected, buttonName: .ok) { (true) in
        self.performSegue(withIdentifier: Segue.goToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
    guard firstAndSecondUsersAreNotSamePerson() else {
      showAlert(title: .errorTitle, message: .canNotSendMessage)
      return
    }
    CheckUsersAlreadyCommunicateBeforeCreatingMessage()
  }

  //MARK: Receive this donation button action
  @IBAction func ReceiveDonationButtonAction(_ sender: Any) {
    guard UserDefaultsService.shared.userToken != nil else {
      showAlert(title: .restrictedTitle, message: .notConnected, buttonName: .ok) { (true) in
        self.performSegue(withIdentifier: Segue.goToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
    guard firstAndSecondUsersAreNotSamePerson() else {
      showAlert(title: .errorTitle, message: .canNotSelectOwnDonation)
      return
    }
    userPicksUpADonatedItem()
  }
}

//MARK: - Main setup
extension ItemSelectedVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupOutletsCollectionsOrder()
    setupMainView()
    setupMessageAndReceiveButtons()
    setupAllLabels()
    setupMapView()
    setupStaticLabels()
    setupItemDescriptionBackgroundView()
    setupItemDescriptionTextView()
    setupItemImage()
    setupUnderlineView()
  }

  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Design setup
extension ItemSelectedVC {
  //MARK: Setup all labels design
  func setupAllLabels() {
    setupItemTypeLabel()
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemNameLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: darkModeColor)
      dateLabel.setupFont(as: .superclarendonBold, sized: .heighteen, in: darkModeColor)
      timeLabel.setupFont(as: .superclarendonBold, sized: .heighteen, in: darkModeColor)
    }
  }

  //MARK: Setup item type label design
  func setupItemTypeLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemTypeLabel.setupFont(as: .arialBold, sized: .twenty, in: darkModeColor)
    }
    itemTypeLabel.textAlignment = .center
  }

  //MARK: Setup map view design
  func setupMapView() {
    mapView.layer.cornerRadius = 10
    mapView.isUserInteractionEnabled = false
  }

  //MARK: Setup item description background view design
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroundView.backgroundColor = .iceBackgroundDarkMode
    itemDescriptionBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroundView.layer.borderWidth = 1
    itemDescriptionBackgroundView.layer.cornerRadius = 10
  }

  //MARK: Setup item description text view design
  func setupItemDescriptionTextView() {
    itemDescriptionTextView.backgroundColor = .iceBackgroundDarkMode
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: darkModeColor)
    }
  }

  //MARK: Setup navigation controller design
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }

  //MARK: Setup outlet collection to be in order
  func setupOutletsCollectionsOrder() {
    staticLabels = staticLabels.sorted(by: { $0.tag < $1.tag })
  }

  //MARK: Setup static labels design
  func setupStaticLabels() {
    staticLabels[0].text = StaticItemDetail.type.description
    staticLabels[1].text = StaticItemDetail.the.description
    staticLabels[2].text = StaticItemDetail.at.description
    for label in staticLabels {
      if let darkModeColor = UIColor.typoBlueGrayDarkMode {
        label.setupFont(as: .arial, sized: .seventeen, in: darkModeColor)
      }
    }
  }

  //MARK: Setup cancel and save buttons design
  func setupMessageAndReceiveButtons() {
    messageToDonatorButton.commonDesign(title: .messageToDonor)
    receiveDonationButton.commonDesign(title: .receiveThisDonation)
  }

  //MARK: Setup item image design
  func setupItemImage() {
    itemImage.layer.cornerRadius = 3
  }

  //MARK: Setup underline view design
  func setupUnderlineView() {
    underlineView.backgroundColor = .mainBlue
  }

  //MARK: Setup userID into senderID varirable
  func setupUserIDToSenderIDVariable() {
    if let id = UserDefaultsService.shared.userID {
      senderID = id
    }
  }
}

//MARK: - Populate donated item info
extension ItemSelectedVC {
  func setupVCInfoFrom(_ donorItem: DonatedItem) {
    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    let date = dateAndTime?.asString(style: .short)
    let time = dateAndTime?.asString()

    itemTypeLabel.text = donorItem.selectedType
    itemNameLabel.text = donorItem.name
    dateLabel.text = date
    timeLabel.text = time
    FirebaseStorageHandler.shared.downloadItemImage(of: donorItem, into: itemImage)
    LocationHandler.shared.itemAnnotationShown(on: mapView, latitude: donorItem.latitude, longitude: donorItem.longitude)
    itemDescriptionTextView.text = donorItem.description
  }
}

//MARK: - Setup favorite button when an user favorites an donated item or not
extension ItemSelectedVC {
  func updateFavoriteButton(_ isFavorite: Bool) {
    favoriteButton.addTarget(self, action: #selector(favoriteDidTap), for: .touchUpInside)
    if isFavorite {
      favoriteButton.setImage(UIImage(named: ImageName.fullHeart.rawValue), for: .normal)
    }
    else {
      favoriteButton.setImage(UIImage(named: ImageName.emptyHeart.rawValue), for: .normal)
    }
  }

  // Actions for when the heart is clicked
  @objc func favoriteDidTap() {
    isFavorited = !isFavorited
    if self.isFavorited {
      saveDonatedItemToUserFavorite()
    }
    else {
      deleteDonatedItemFromUserFavorite()
    }
    updateFavoriteButton(isFavorited)
  }

  //Check if the donated item was once favorited and saved
  func wasRecipeFavorited() {
    isFavorited = false
    checkIfAnUserFavoritedItem()
  }
}

//MARK: - Populate info depending of whom is the donor or receiver
extension ItemSelectedVC {
  func populateReceiver() {
    if let anotherUserID = self.receiver?.id?.uuidString {
      self.secondUserID = anotherUserID
    }
  }

  func populateDonor() {
    if let oneUserID = self.donor?.id?.uuidString {
      self.firstUserID = oneUserID
    }
  }
}

//MARK: - Activity Indicator action and setup
extension ItemSelectedVC {
  func triggerMessageActivityIndicator(_ action: Bool) {
    triggerActivityIndicator(
      action, on: messageActivityIndicator, as: messageToDonatorButton, named: .messageToDonor)
  }
  
  func triggerReceiveDonationActivityIndicator(_ action: Bool) {
    triggerActivityIndicator(
      action, on: receiveActivityIndicator, as: receiveDonationButton, named: .receiveThisDonation)
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
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.color = .iceBackground
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    button.commonDesign(title: .emptyString)
    button.isHidden = false
  }

  func hideActivityIndicator(
    _ activityIndicator: UIActivityIndicatorView, _ button: UIButton, _ name: ButtonName) {
    activityIndicator.isHidden = true
    button.commonDesign(title: name)
  }

  func hideAllActivityIndicators() {
    triggerActivityIndicator(
      false, on: messageActivityIndicator, as: messageToDonatorButton, named: .messageToDonor)
    triggerActivityIndicator(
      false, on: receiveActivityIndicator, as: receiveDonationButton, named: .receiveThisDonation)
  }
}

//MARK: - Prepare for segue
extension ItemSelectedVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goToMapViewVC.rawValue {
      let destinationVC = segue.destination as! MapViewVC
      destinationVC.donorItemLatitude = donatedItem.latitude
      destinationVC.donorItemLongitude = donatedItem.longitude
      destinationVC.buttonName = .openMapApp
    }
    else if segue.identifier == Segue.unwindToMessageVC.rawValue {
      let destinationVC = segue.destination as? MessageVC
      destinationVC?.firstUserID = firstUserID
      destinationVC?.secondUserID = secondUserID
    }
    else if segue.identifier == Segue.goToItemImagesVC.rawValue {
      let destinationVC = segue.destination as? ItemImagesVC
      destinationVC?.isReceiver = true
      destinationVC?.donorItem = donatedItem
    }
    else if segue.identifier == Segue.unwindToSharingVC.rawValue {
      let destinationVC = segue.destination as? SharingVC
      destinationVC?.displayAd = authToDisplayGoogleAd
    }
  }
}

//MARK: - API calls
extension ItemSelectedVC {
  //MARK: Save item to user favorite
  func saveDonatedItemToUserFavorite() {
    guard UserDefaultsService.shared.userID != nil else {
      showAlert(title: .loginErrorTitle, message: .notConnected)
      return
    }
    guard let donatedItemID = donatedItem.id else { return }

    let resourcePath =
      NetworkPath.donatedItems.description + "\(donatedItemID)/" +
        NetworkPath.favoritedByUser.description + UserDefaultsService.shared.userID!
    ResourceRequest<DonatedItem>(resourcePath).linkToPivot(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success:
        return
      }
    }
  }

  //MARK: Check if an user favorited the donated item
  func checkIfAnUserFavoritedItem() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let donatedItemID = donatedItem.id else { return }

    let resourcePath =
      NetworkPath.donatedItems.description + "\(donatedItemID)/" +
        NetworkPath.favoritedByUser.description
    ResourceRequest<User>(resourcePath).getAll(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success(let users):
        DispatchQueue.main.async { [weak self] in
          for user in users {
            if user.id?.uuidString == UserDefaultsService.shared.userID {
              self?.isFavorited = true
              self?.favoriteButton.setImage(UIImage(named: ImageName.fullHeart.rawValue), for: .normal)
            }
          }
        }
      }
    }
  }

  //MARK: An user delete his favorited item
  func deleteDonatedItemFromUserFavorite() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let donatedItemID = donatedItem.id else { return }

    let resourcePath =
      NetworkPath.donatedItems.description + "\(donatedItemID)/" +
        NetworkPath.favoritedByUser.description + UserDefaultsService.shared.userID!
    ResourceRequest<DonatedItem>(resourcePath).delete(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success:
        return
      }
    }
  }

  //MARK: User picks up the donated item method and save it in the database
  func userPicksUpADonatedItem() {
    guard let donatedItemID = donatedItem.id else { return }
    guard let receiverID = UserDefaultsService.shared.userID else { return }
    guard var updatedDonatedItem = donatedItem else { return }
    guard !updatedDonatedItem.isPicked else {
      showAlert(title: .itemUnselectableTitle, message: .itemAlreadySelected)
      return
    }
    updatedDonatedItem.receiverID = receiverID
    updatedDonatedItem.isPicked = true

    showAlert(title: .itemSelectedTitle, message: .confirmSelection, buttonName: .confirm, completion: { (true) in

      let resourcePath = NetworkPath.donatedItems.description + "\(donatedItemID)"
      self.triggerReceiveDonationActivityIndicator(true)
      ResourceRequest<DonatedItem>(resourcePath).update(updatedDonatedItem, tokenNeeded: true, { (result) in
        switch result {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.triggerReceiveDonationActivityIndicator(false)
            self?.showAlert(title: .errorTitle, message: .networkRequestError)
          }
        case .success(let pickedUpItem):
          DispatchQueue.main.async { [weak self] in
            updatedDonatedItem = pickedUpItem
            self?.triggerReceiveDonationActivityIndicator(false)
            self?.authToDisplayGoogleAd = true
            self?.showAlert(title: .successTitle, message: .donatedItemSelected, completion: { (true) in
              self?.performSegue(withIdentifier: Segue.unwindToSharingVC.rawValue, sender: self)
            })
          }
        }
      })
    })
  }

  //MARK: Fetch the receiver from the database to get users info
  func fetchReceiverFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let receiverID = UserDefaultsService.shared.userID else { return }

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

  //MARK: Fetch the donor from the database to get users info
  func fetchDonorFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let itemID = donatedItem.id else { return }

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

  //MARK: User send a message to another user
  func createMessageBetweenTwoUser() {
    guard UserDefaultsService.shared.userID != nil else { return }
    let dateAndTime = ISO8601DateFormatter.string(
      from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)

    guard let recipientID = donor?.id?.uuidString else { return }

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
          self?.triggerMessageActivityIndicator(false)
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
    let userID = UserDefaultsService.shared.userID
    var userAlreadyCommunicate = false

    let resourcePath =
      NetworkPath.messages.description + NetworkPath.ofUser.description + userID!
    triggerMessageActivityIndicator(true)
    ResourceRequest<Message>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.triggerMessageActivityIndicator(false)
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success(let fetchedMessages):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.messages = [Message]()
          self.messages.append(contentsOf: fetchedMessages)
          if self.messages.isEmpty {
            self.createMessageBetweenTwoUser()
          }
          else {
            //Check if users are already connected
            for message in self.messages {
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
          self.triggerMessageActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Check if firstUser is the same as secondUser to avoid user messaging to himself
extension ItemSelectedVC {
  func firstAndSecondUsersAreNotSamePerson() -> Bool {
    return firstUserID != secondUserID
  }
}

//MARK: - Fetch donor and receiver from the database
extension ItemSelectedVC {
  func fetchUsersFromTheDatabase() {
    fetchReceiverFromTheDatabase()
    fetchDonorFromTheDatabase()
  }
}
