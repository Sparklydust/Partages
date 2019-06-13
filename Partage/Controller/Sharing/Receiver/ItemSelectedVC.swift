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
  @IBOutlet weak var itemImageButton: UIButton!
  @IBOutlet weak var mapViewButton: UIButton!
  
  @IBOutlet weak var itemDescriptionBackgroundView: UIView!
  
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet var staticLabels: [UILabel]!
  @IBOutlet var messageAndReceiveButtons: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
  }
}

//MARK: -
extension ItemSelectedVC {
  @IBAction func favoriteButtonAction(_ sender: Any) {
  }
}

//MARK: -
extension ItemSelectedVC {
  @IBAction func itemImageButtonAction(_ sender: Any) {
  }
}

//MARK: -
extension ItemSelectedVC {
  @IBAction func mapViewButtonAction(_ sender: Any) {
  }
}

//MARK: -
extension ItemSelectedVC {
  @IBAction func messageToDonatorButtonAction(_ sender: Any) {
  }
}

//MARK: -
extension ItemSelectedVC {
  @IBAction func ReceiveThisDonationButtonAction(_ sender: Any) {
  }
}

//MARK: - Setup developer main design
extension ItemSelectedVC {
  func setupMainDesign() {
    view.backgroundColor = UIColor.iceBackground
    navigationItem.setupNavBarProfileImage()
    setupMessageAndReceiveButtons()
    setupItemTypeLabel()
    setupItemNameLabel()
    setupDateLabel()
    setupTimeLabel()
    setupMapView()
    setupStaticLabels()
    setupItemDescriptionBackgroundView()
    setupItemDescriptionTextView()
  }
}

//MARK: - Setup item type label design
extension ItemSelectedVC {
  func setupItemTypeLabel() {
    itemTypeLabel.font = UIFont(customFont: .arialBold, withSize: .twenty)
    itemTypeLabel.textColor = UIColor.typoBlue
    itemTypeLabel.textAlignment = .center
  }
}

//MARK: - Setup item name label design
extension ItemSelectedVC {
  func setupItemNameLabel() {
    itemNameLabel.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    itemNameLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup date label design
extension ItemSelectedVC {
  func setupDateLabel() {
    dateLabel.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    dateLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup time label design
extension ItemSelectedVC {
  func setupTimeLabel() {
    timeLabel.font = UIFont(customFont: .superclarendonBold, withSize: .twenty)
    timeLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup map view design
extension ItemSelectedVC {
  func setupMapView() {
    mapView.layer.cornerRadius = 10
  }
}

//MARK: - Setup item description background view design
extension ItemSelectedVC {
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroundView.backgroundColor = UIColor.iceBackground
    itemDescriptionBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroundView.layer.borderWidth = 1
    itemDescriptionBackgroundView.layer.cornerRadius = 10
  }
}

//MARK: - Setup item description text view design
extension ItemSelectedVC {
  func setupItemDescriptionTextView() {
    itemDescriptionTextView.backgroundColor = UIColor.iceBackground
    itemDescriptionTextView.textColor = UIColor.typoBlue
    itemDescriptionTextView.font = UIFont(customFont: .arialBold, withSize: .seventeen)
  }
}

//MARK: - Setup static labels
extension ItemSelectedVC {
  func setupStaticLabels() {
    staticLabels[0].text = StaticItemDetail.type.rawValue
    staticLabels[1].text = StaticItemDetail.the.rawValue
    staticLabels[2].text = StaticItemDetail.at.rawValue
    for label in staticLabels {
      label.font = UIFont(customFont: .arialBold, withSize: .heighteen)
      label.textColor = UIColor.typoBlue
    }
  }
}

//MARK: - Setup cancel and save buttons design
extension ItemSelectedVC {
  func setupMessageAndReceiveButtons() {
    for button in messageAndReceiveButtons {
      button.backgroundColor = UIColor.mainBlue
      button.setTitleColor(UIColor.lightBlue, for: .normal)
    }
    messageAndReceiveButtons[0].commonDesign(title: .messageToDonator, shadowWidth: 0, shadowHeight: -2)
    messageAndReceiveButtons[1].commonDesign(title: .receiveThisDonation, shadowWidth: 0, shadowHeight: 2)
  }
}