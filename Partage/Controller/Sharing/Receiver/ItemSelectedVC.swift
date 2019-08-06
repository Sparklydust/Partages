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
  
  @IBOutlet var staticLabels: [UILabel]!
  
  var donatedItem: DonatedItem!
  var isFavorited = false
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    wasRecipeFavorited()
    updateFavoriteButton(isFavorited)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupVCInfoFrom(donatedItem)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
}

//MARK: - Buttons actions
extension ItemSelectedVC {
  //MARK: Favorite button action
  @IBAction func favoriteButtonAction(_ sender: Any) {
    guard UserDefaultsService.shared.token != nil else {
      showAlert(title: .restricted, message: .notConnected, buttonName: .ok) { (true) in
        self.performSegue(withIdentifier: Segue.goesToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
  }
  
  //MARK: Item image button action
  @IBAction func itemImageButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goesToItemImagesVC.rawValue, sender: self)
  }
  
  //MARK: Map view button action
  @IBAction func mapViewButtonAction(_ sender: Any) {
    performSegue(withIdentifier: Segue.goesToMapViewVC.rawValue, sender: self)
  }
  
  //MARK: Messagge to donator button action
  @IBAction func messageToDonatorButtonAction(_ sender: Any) {
    guard UserDefaultsService.shared.token != nil else {
      showAlert(title: .restricted, message: .notConnected, buttonName: .ok) { (true) in
        self.performSegue(withIdentifier: Segue.goesToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }

  }
  
  //MARK: Receive this donation button action
  @IBAction func ReceiveDonationButtonAction(_ sender: Any) {
    guard UserDefaultsService.shared.token != nil else {
      showAlert(title: .restricted, message: .notConnected, buttonName: .ok) { (true) in
        self.performSegue(withIdentifier: Segue.goesToSignInSignUpVC.rawValue, sender: self)
      }
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
    setupNavigationController()
  }

//MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
}

//MARK: - Setup all labels design
extension ItemSelectedVC {
  func setupAllLabels() {
    setupItemTypeLabel()
    itemNameLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .typoBlue)
    dateLabel.setupFont(as: .superclarendonBold, sized: .heighteen, in: .typoBlue)
    timeLabel.setupFont(as: .superclarendonBold, sized: .heighteen, in: .typoBlue)
  }
}

//MARK: - Setup item type label design
extension ItemSelectedVC {
  func setupItemTypeLabel() {
    itemTypeLabel.setupFont(as: .arialBold, sized: .twenty, in: .typoBlue)
    itemTypeLabel.textAlignment = .center
  }
}

//MARK: - Setup map view design
extension ItemSelectedVC {
  func setupMapView() {
    mapView.layer.cornerRadius = 10
    mapView.isUserInteractionEnabled = false
  }
}

//MARK: - Setup item description background view design
extension ItemSelectedVC {
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroundView.backgroundColor = .iceBackground
    itemDescriptionBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroundView.layer.borderWidth = 1
    itemDescriptionBackgroundView.layer.cornerRadius = 10
  }
}

//MARK: - Setup item description text view design
extension ItemSelectedVC {
  func setupItemDescriptionTextView() {
    itemDescriptionTextView.backgroundColor = .iceBackground
    itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: .typoBlue)
  }
}

//MARK: - Setup navigation controller design
extension ItemSelectedVC {
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup outlet collection to be in order
extension ItemSelectedVC {
  func setupOutletsCollectionsOrder() {
    staticLabels = staticLabels.sorted(by: { $0.tag < $1.tag })
  }
}

//MARK: - Setup static labels design
extension ItemSelectedVC {
  func setupStaticLabels() {
    staticLabels[0].text = StaticItemDetail.type.rawValue
    staticLabels[1].text = StaticItemDetail.the.rawValue
    staticLabels[2].text = StaticItemDetail.at.rawValue
    for label in staticLabels {
      label.setupFont(as: .arial, sized: .seventeen, in: .typoBlue)
    }
  }
}

//MARK: - Setup cancel and save buttons design
extension ItemSelectedVC {
  func setupMessageAndReceiveButtons() {
    messageToDonatorButton.commonDesign(title: .messageToDonor)
    receiveDonationButton.commonDesign(title: .receiveThisDonation)
  }
}

//MARK: - Setup item image design
extension ItemSelectedVC {
  func setupItemImage() {
    itemImage.layer.cornerRadius = 3
  }
}

//MARK: - Setup underline view design
extension ItemSelectedVC {
  func setupUnderlineView() {
    underlineView.backgroundColor = .mainBlue
  }
}

//MARK: - Populate donated item info
extension ItemSelectedVC {
  func setupVCInfoFrom(_ donorItem: DonatedItem) {
    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(of: StaticLabel.dateOccurence.rawValue, with: StaticLabel.emptyString.rawValue, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    let date = dateAndTime?.asString(style: .short)
    let time = dateAndTime?.asString()
    
    itemTypeLabel.text = donorItem.selectedType
    itemNameLabel.text = donorItem.name
    dateLabel.text = date
    timeLabel.text = time
    LocationHandler.shared.itemAnnotationShown(on: mapView, latitude: donorItem.latitude, longitude: donorItem.longitude)
    itemDescriptionTextView.text = donorItem.description
  }
}

//MARK: - Prepare for segue methods
extension ItemSelectedVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goesToMapViewVC.rawValue {
      let destinationVC = segue.destination as! MapViewVC
      destinationVC.donorItemLatitude = donatedItem.latitude
      destinationVC.donorItemLongitude = donatedItem.longitude
      destinationVC.buttonName = .openMapApp
    }
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

//MARK: - Save item to user favorite
extension ItemSelectedVC {
  func saveDonatedItemToUserFavorite() {
    guard UserDefaultsService.shared.userID != nil else {
      showAlert(title: .loginError, message: .notConnected)
      return
    }
    guard let donatedItemID = donatedItem.id else { return }
    
    let resourcePath = NetworkPath.donatedItems.rawValue + "\(donatedItemID)/" + NetworkPath.favoritedByUser.rawValue + UserDefaultsService.shared.userID!
    ResourceRequest<DonatedItem>(resourcePath).linkToPivot(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success:
        return
      }
    }
  }
}

//MARK: - Check if an user favorited the donated item
extension ItemSelectedVC {
  func checkIfAnUserFavoritedItem() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let donatedItemID = donatedItem.id else { return }

    let resourcePath = NetworkPath.donatedItems.rawValue + "\(donatedItemID)/" + NetworkPath.favoritedByUser.rawValue
    ResourceRequest<User>(resourcePath).getAll(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
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
}

//MARK: - An user delete his favorited item
extension ItemSelectedVC {
  func deleteDonatedItemFromUserFavorite() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let donatedItemID = donatedItem.id else { return }
    
    let resourcePath = NetworkPath.donatedItems.rawValue + "\(donatedItemID)/" + NetworkPath.favoritedByUser.rawValue + UserDefaultsService.shared.userID!
    ResourceRequest<DonatedItem>(resourcePath).delete(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success:
        return
      }
    }
    
  }
}

//MARK: - User picks up the donated item method and save it in the database
extension ItemSelectedVC {
  func userPicksUpADonatedItem() {
    guard let donatedItemID = donatedItem.id else { return }
    guard let receiverID = UserDefaultsService.shared.userID else { return }
    guard var updatedDonatedItem = donatedItem else { return }
    guard !updatedDonatedItem.isPicked else {
      showAlert(title: .donatedItemUnselectable, message: .itemAlreadySelected)
      return
    }
    updatedDonatedItem.receiverID = receiverID
    updatedDonatedItem.isPicked = true
    
    showAlert(title: .donatedItemSelected, message: .confirmSelection, buttonName: .confirm, completion: { (true) in
      
      let resourcePath = NetworkPath.donatedItems.rawValue + "\(donatedItemID)"
      ResourceRequest<DonatedItem>(resourcePath).update(updatedDonatedItem, tokenNeeded: true, { (result) in
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
