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
  @IBOutlet weak var underlineView: UIView!
  @IBOutlet weak var itemDescriptionBackgroudView: UIView!
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  @IBOutlet weak var donatorReceiverProfileImage: UIImageView!
  @IBOutlet weak var itemImage: UIImageView!
  @IBOutlet weak var addToCalendarButton: UIButton!
  @IBOutlet weak var messageToButton: UIButton!
  @IBOutlet weak var itemPictureButton: UIButton!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet var staticItemDetailsLabels: [UILabel]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    donatorReceiverProfileImage.roundedWithMainBlueBorder()
  }
}

//MARK: - Buttons actions
extension ItemDetailsVC {
  //MARK: Item picture button action
  @IBAction func itemPictureButtonAction(_ sender: Any) {
  }
  
  //MARK: Map kit view button action
  @IBAction func mapKitButtonAction(_ sender: Any) {
  }
  
  //MARK: Add to calendar or modify button action
  @IBAction func addToCalendarButtonAction(_ sender: Any) {
  }
  
  //MARK: Message to receiver or donator button action
  @IBAction func messageToButtonAction(_ sender: Any) {
  }
  
  //MARK: Edit donation button action
  @IBAction func editButtonAction(_ sender: Any) {
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
    donatorReceiverNameLabel.setupFont(as: .superclarendonBold, sized: .seventeen, in: .typoBlue)
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
    staticLabelReceiverOrDonator()
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
    itemImage.layer.cornerRadius = 2
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
    buttonsNameReceiverOrDonator()
    addToCalendarButton.commonDesign(title: .addToCalendar)
  }
}

//MARK: - Setup depending on receiver or donator
extension ItemDetailsVC {
  func buttonsNameReceiverOrDonator() {
    messageToButton.commonDesign(title: .messageToReceiver)
  }
  
  func staticLabelReceiverOrDonator() {
    staticItemDetailsLabels[0].text = StaticItemDetail.receiveDonation.rawValue
  }
  
  func mapKitReceiverOrDonator() {
    
  }
}
