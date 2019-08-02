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
  
  @IBOutlet var staticItemDetailsLabels: [UILabel]!
  
  var itemDetails: DonatedItem!
  var calendarTitle = String()
  var address = String()
  
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
    populateIfNeededDonorOrReceiverInfo()
    fetchDonorIDFromSelectedItem()
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
    performSegue(withIdentifier: Segue.goesToItemImagesVC.rawValue, sender: self)
  }
  
  //MARK: Map kit view button action
  @IBAction func mapKitButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goesToMapViewVC.rawValue, sender: self)
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
  }
  
  //MARK: Edit donation button action
  @IBAction func editButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goesToDonatorVC.rawValue, sender: self)
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
    setupNavigationController()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Setup main labels design
extension ItemDetailsVC {
  func setupMainLabels() {
    itemNameLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
    donorReceiverNameLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
    dateLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
    timeLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
  }
}

//MARK: - Setup outlet collection to be in order
extension ItemDetailsVC {
  func setupOutletsCollectionsOrder() {
    staticItemDetailsLabels = staticItemDetailsLabels.sorted(by: { $0.tag < $1.tag })
  }
}

//MARK: - Setup all static Labels design
extension ItemDetailsVC {
  func setupStaticItemDetailsLabels() {
    staticLabelReceiverOrDonor()
    staticItemDetailsLabels[1].text = StaticItemDetail.the.rawValue
    staticItemDetailsLabels[2].text = StaticItemDetail.at.rawValue
    staticItemDetailsLabels[3].text = StaticItemDetail.address.rawValue
    for label in staticItemDetailsLabels {
      label.setupFont(as: .arial, sized: .seventeen, in: .typoBlue)
    }
  }
}

//MARK: - Setup underline view background color design
extension ItemDetailsVC {
  func setupUnderlineViewBackgroundColor() {
    underlineView.setupBackgroundColorIn(.mainBlue)
  }
}

//MARK: - Setup item description text view and background view design
extension ItemDetailsVC {
  func setupItemDescriptionTextView() {
    itemDescriptionTextView.isEditable = false
    itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: .typoBlue)
    setupItemDescriptionBackgroundView()
  }
  
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroudView.layer.cornerRadius = 10
    itemDescriptionBackgroudView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroudView.layer.borderWidth = 1
  }
}

//MARK: - Setup map kit view view design
extension ItemDetailsVC {
  func setupMapView() {
    mapView.layer.cornerRadius = 10
  }
}

//MARK: - Setup edit button design
extension ItemDetailsVC {
  func setupEditButton() {
    editButton.editButtonDesign()
  }
}

//MARK: - Setup item image design
extension ItemDetailsVC {
  func setupItemImage() {
    itemImage.layer.cornerRadius = 3
  }
}

//MARK: - Setup navigation controller design
extension ItemDetailsVC {
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
    guard UserDefaultsService.userID == itemDetails.receiverID || !itemDetails.isPicked else {
      messageToButton.commonDesign(title: .messageToReceiver)
      return
    }
    messageToButton.commonDesign(title: .messageToDonor)
  }
  
  func staticLabelReceiverOrDonor() {
    guard UserDefaultsService.userID == itemDetails.receiverID else {
      staticItemDetailsLabels[0].text = StaticItemDetail.receiveDonation.rawValue
      return
    }
    staticItemDetailsLabels[0].text = StaticItemDetail.giveDonation.rawValue
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goesToMapViewVC.rawValue {
      let destinationVC = segue.destination as! MapViewVC
      destinationVC.donorItemLatitude = itemDetails.latitude
      destinationVC.donorItemLongitude = itemDetails.longitude
      destinationVC.buttonName = .openMapApp
    }
    else if segue.identifier == Segue.goesToDonatorVC.rawValue {
      let destinationVC = segue.destination as? DonorVC
      destinationVC?.itemToEdit = itemDetails
      destinationVC?.buttonName = .modifyDonation
    }
  }
}

//MARK: - Populate donated item info
extension ItemDetailsVC {
  func setupVCInfoFrom(_ donorItem: DonatedItem) {
    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(of: StaticLabel.dateOccurence.rawValue, with: StaticLabel.emptyString.rawValue, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    let date = dateAndTime?.asString(style: .short)
    let time = dateAndTime?.asString()
    
    itemNameLabel.text = donorItem.name
    dateLabel.text = date
    timeLabel.text = time
    LocationHandler.shared.itemAnnotationShown(on: mapView, latitude: donorItem.latitude, longitude: donorItem.longitude)
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
        self?.showAlert(title: .error, message: .locationIssue)
        return
      }
      guard let placemark = placemarks?.first else {
        self?.showAlert(title: .error, message: .locationIssue)
        return
      }
      let streetNumber = placemark.subThoroughfare ?? ""
      let streetName = placemark.thoroughfare ?? ""
      let postalCode = placemark.postalCode ?? ""
      let cityName = placemark.locality ?? ""
      let countryName = placemark.country ?? ""
      
      DispatchQueue.main.async { [weak self] in
        self?.address = "\(streetNumber) \(streetName) \(postalCode) \(cityName), \(countryName.uppercased())"
      }
    }
  }
}

//MARK: - Method to add the detailed item in the user calendar as en event
extension ItemDetailsVC {
  func addItemToCalendar() {
    let isoDateString = itemDetails.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(of: StaticLabel.dateOccurence.rawValue, with: StaticLabel.emptyString.rawValue, options: .regularExpression)
    if UserDefaultsService.userID == itemDetails.receiverID {
      calendarTitle = StaticLabel.receiverCalendarTitle.rawValue + itemDetails.name
    }
    else {
      calendarTitle = StaticLabel.donorCalendarTitle.rawValue + itemDetails.name
    }
    guard let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString) else { return }
    EventHandler.shared.addEventToCalendar(vc: self, title: calendarTitle, location: address, startDate: dateAndTime, notes: itemDetails.description)
  }
}

//MARK: - Populate or not the donor or receiver name and profile picture
extension ItemDetailsVC {
  func populateIfNeededDonorOrReceiverInfo() {
    guard itemDetails.isPicked else {
      hideUserInfoAndStaticLabel()
      showEditButton()
      return
    }
    if UserDefaultsService.userID != itemDetails.receiverID {
      fetchReceiverFromTheDatabase()
    }
    else {
      hideEditButton()
      fetchDonorIDFromSelectedItem()
      fetchDonorFromTheDatabase()
    }
  }
  
  func populateReceiver() {
    guard let firstName = receiver?.firstName else { return }
    donorReceiverNameLabel.text = firstName
  }
  
  func populateDonor() {
    guard let firstName = donor?.firstName else { return }
    donorReceiverNameLabel.text = firstName
    guard donor?.id?.uuidString == UserDefaultsService.userID && !itemDetails.isPicked else { return }
    addToCalendarButton.isHidden = true
    messageToButton.isHidden = true
  }
}

//MARK: - Show or hide edit button methods
extension ItemDetailsVC {
  func showEditButton() {
    editButton.title = ButtonName.edit.rawValue
    editButton.isEnabled = true
  }
  
  func hideEditButton() {
    editButton.title = StaticLabel.emptyString.rawValue
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

//MARK: - Fetch the receiver or donor from the database to populate donorReceiverNameLabel and picture
extension ItemDetailsVC {
  func fetchReceiverFromTheDatabase() {
    guard UserDefaultsService.userID != nil else { return }
    guard let receiverID = itemDetails.receiverID else { return }
    
    let resourcePath = NetworkPath.users.rawValue + receiverID
    ResourceRequest<User>(resourcePath: resourcePath).get { [weak self] (result) in
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
  
  func fetchDonorFromTheDatabase() {
    guard UserDefaultsService.userID != nil else { return }
    guard let donorID = donor?.id?.uuidString else { return }
    
    let resourcePath = NetworkPath.users.rawValue + donorID
    ResourceRequest<User>(resourcePath: resourcePath).get { [weak self] (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .loginError)
        }
      case .success(let user):
        DispatchQueue.main.async { [weak self] in
          self?.donor = user
        }
      }
    }
  }
  
  func fetchDonorIDFromSelectedItem() {
    guard UserDefaultsService.userID != nil else { return }
    guard let itemID = itemDetails.id else { return }
    
    let resourcePath = NetworkPath.donatedItems.rawValue + "\(itemID)/" + "user"
    ResourceRequest<User>(resourcePath: resourcePath).get { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success(let user):
        DispatchQueue.main.async { [weak self] in
          self?.donor = user
        }
      }
    }
  }
}

//MARK: - User picks up a donated item and save it in the database
extension ItemDetailsVC {
  func userPicksUpADonatedItem() {
    guard let donatedItemID = itemDetails.id else { return }
    guard let receiverID = UserDefaultsService.userID else { return }
    guard var updatedDonatedItem = itemDetails else { return }
    guard !updatedDonatedItem.isPicked else {
      showAlert(title: .donatedItemUnselectable, message: .itemAlreadySelected)
      return
    }
    updatedDonatedItem.receiverID = receiverID
    updatedDonatedItem.isPicked = true
    
    showAlert(title: .donatedItemSelected, message: .confirmSelection, buttonName: .confirm, completion: { (true) in
      
      let resourcePath = NetworkPath.donatedItems.rawValue + "\(donatedItemID)"
      ResourceRequest<DonatedItem>(resourcePath: resourcePath).update(with: updatedDonatedItem, completion: { (result) in
        switch result {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: .error, message: .networkRequestError)
          }
        case .success(let pickedUpItem):
          DispatchQueue.main.async { [weak self] in
            updatedDonatedItem = pickedUpItem
            self?.showAlert(title: .success, message: .donatedItemSelected, completion: { (true) in
              self?.performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: self)
            })
          }
        }
      })
    })
  }
}
