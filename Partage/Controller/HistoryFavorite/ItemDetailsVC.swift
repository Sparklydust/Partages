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
  @IBOutlet weak var donatorReceiverNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  @IBOutlet weak var littleBarView: UIView!
  @IBOutlet weak var itemDescriptionBackgroudView: UIView!
  
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  
  @IBOutlet weak var donatorReceiverProfileImage: UIImageView!
  
  @IBOutlet weak var itemPictureButton: UIButton!
  
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet var staticItemDetailsLabels: [UILabel]!
  @IBOutlet var addModifyMessageButton: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.setupNavBarProfileImage()
    setupMainDesign()
  }
}

//MARK: - Item picture button action
extension ItemDetailsVC {
  @IBAction func itemPictureButtonAction(_ sender: Any) {
  }
}

//MARK: - Map kit view button action
extension ItemDetailsVC {
  @IBAction func mapKitButtonAction(_ sender: Any) {
  }
}

//MARK: - Add to calendar or modify button action
extension ItemDetailsVC {
  @IBAction func addOrModifyButtonAction(_ sender: Any) {
  }
}

//MARK: - Message to receiver or donator button action
extension ItemDetailsVC {
  @IBAction func messageToButtonAction(_ sender: Any) {
  }
}

//MARK: - Setup main developer design
extension ItemDetailsVC {
  func setupMainDesign() {
    setupMainLabels()
    setupStaticItemDetailsLabels()
    setupLittleBarViewBackgroundColor()
    setupAddModifyMessageButton()
    setupItemDescriptionTextView()
    donatorReceiverProfileImage.roundedWithMainBlueBorder()
  }
}

//MARK: - Setup main labels design
extension ItemDetailsVC {
  func setupMainLabels() {
    setupMainLabelsFont()
    setupMainLabelsTextColor()
  }
  
  func setupMainLabelsFont() {
    itemNameLabel.font = UIFont(customFont: .superclarendonBold, withSize: .seventeen)
    donatorReceiverNameLabel.font = UIFont(customFont: .superclarendonBold, withSize: .seventeen)
    dateLabel.font = UIFont(customFont: .superclarendonBold, withSize: .seventeen)
    timeLabel.font = UIFont(customFont: .superclarendonBold, withSize: .seventeen)
  }
  
  func setupMainLabelsTextColor() {
    itemNameLabel.textColor = UIColor.typoBlue
    donatorReceiverNameLabel.textColor = UIColor.typoBlue
    dateLabel.textColor = UIColor.typoBlue
    timeLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup all static Labels design
extension ItemDetailsVC {
  func setupStaticItemDetailsLabels() {
    staticLabelReceiverOrDonator()
    staticItemDetailsLabels[1].text = StaticItemDetail.the.rawValue
    staticItemDetailsLabels[2].text = StaticItemDetail.at.rawValue
    staticItemDetailsLabels[3].text = StaticItemDetail.address.rawValue
    for label in staticItemDetailsLabels {
      label.font = UIFont(customFont: .arial, withSize: .seventeen)
      label.textColor = UIColor.typoBlue
    }
  }
}

//MARK: - Setup little bar view background color design
extension ItemDetailsVC {
  func setupLittleBarViewBackgroundColor() {
    littleBarView.backgroundColor = UIColor.mainBlue
  }
}

//MARK: - Setup item description text view and background view design
extension ItemDetailsVC {
  func setupItemDescriptionTextView() {
    itemDescriptionTextView.isEditable = false
    itemDescriptionTextView.font = UIFont(customFont: .arialBold, withSize: .seventeen)
    itemDescriptionTextView.textColor = UIColor.typoBlue
    setupItemDescriptionBackgroundView()
  }
  
  func setupItemDescriptionBackgroundView() {
    itemDescriptionBackgroudView.backgroundColor = UIColor.iceBackground
    itemDescriptionBackgroudView.layer.cornerRadius = 10
    itemDescriptionBackgroudView.layer.borderColor = UIColor.mainBlue.cgColor
    itemDescriptionBackgroudView.layer.borderWidth = 1
  }
}

//MARK: - Setup add or modify and message button design
extension ItemDetailsVC {
  func setupAddModifyMessageButton() {
    buttonsNameReceiverOrDonator()
    for button in addModifyMessageButton {
      button.backgroundColor = UIColor.mainBlue
      button.setTitleColor(UIColor.lightBlue, for: .normal)
    }
  }
}

//MARK: - Setup depending on receiver or donator
extension ItemDetailsVC {
  func buttonsNameReceiverOrDonator() {
    addModifyMessageButton[0].commonDesign(title: .addToCalendar, shadowWidth: 0, shadowHeight: -2)
    addModifyMessageButton[1].commonDesign(title: .messageToDonator, shadowWidth: 0, shadowHeight: 2)
  }
  
  func staticLabelReceiverOrDonator() {
    staticItemDetailsLabels[0].text = StaticItemDetail.giveDonation.rawValue
  }
  
  func mapKitReceiverOrDonator() {
    
  }
}
