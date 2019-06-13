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
    setupAllLabels()
    setupMapView()
    setupStaticLabels()
    setupItemDescriptionBackgroundView()
    setupItemDescriptionTextView()
  }
}

//MARK: - Setup all labels design
extension ItemSelectedVC {
  func setupAllLabels() {
    setupItemTypeLabel()
    itemNameLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .typoBlue)
    dateLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .typoBlue)
    timeLabel.setupFont(as: .superclarendonBold, sized: .twenty, in: .typoBlue)
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
    itemDescriptionTextView.setupFont(as: .arialBold, sized: .seventeen, in: .typoBlue)
  }
}

//MARK: - Setup static labels
extension ItemSelectedVC {
  func setupStaticLabels() {
    staticLabels[0].text = StaticItemDetail.type.rawValue
    staticLabels[1].text = StaticItemDetail.the.rawValue
    staticLabels[2].text = StaticItemDetail.at.rawValue
    for label in staticLabels {
      label.setupFont(as: .arialBold, sized: .heighteen, in: .typoBlue)
    }
  }
}

//MARK: - Setup cancel and save buttons design
extension ItemSelectedVC {
  func setupMessageAndReceiveButtons() {
    messageAndReceiveButtons[0].commonDesign(title: .messageToDonator, shadowWidth: 0, shadowHeight: -2)
    messageAndReceiveButtons[1].commonDesign(title: .receiveThisDonation, shadowWidth: 0, shadowHeight: 2)
  }
}
