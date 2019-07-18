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
  
  var donatorItem: DonatedItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    //setupVCInfofrom(donatorItem)
  }
}

//MARK: - Buttons actions
extension ItemSelectedVC {
  //MARK: Favorite button action
  @IBAction func favoriteButtonAction(_ sender: Any) {
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
  }
  
  //MARK: Receive this donation button action
  @IBAction func ReceiveDonationButtonAction(_ sender: Any) {
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
    messageToDonatorButton.commonDesign(title: .messageToDonator)
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

////MARK: - Populate donated item info
//extension ItemSelectedVC {
//  func setupVCInfofrom(_ donatorItem: DonatorItem) {
//    let isoDateString = donatorItem.pickUpDate
//    let trimmedIsoString = isoDateString.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
//    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
//    let date = dateAndTime?.asString(style: .short)
//    let time = dateAndTime?.asString()
//
//    itemTypeLabel.text = donatorItem.selectedType
//    itemNameLabel.text = donatorItem.name
//    dateLabel.text = date
//    timeLabel.text = time
//    LocationHandler.shared.itemAnnotationShown(on: mapView, latitude: donatorItem.latitude, longitude: donatorItem.longitude)
//    itemDescriptionTextView.text = donatorItem.description
//  }
//}

//MARK: - Prepare for segue methods
extension ItemSelectedVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goesToMapViewVC.rawValue {
      let destinationVC = segue.destination as! MapViewVC
      destinationVC.donatorItemLatitude = donatorItem.latitude
      destinationVC.donatorItemLongitude = donatorItem.longitude
      destinationVC.buttonName = .openMapApp
    }
  }
}
