//
//  ReceiverTVC.swift
//  Partage
//
//  Created by Roland Lariotte on 11/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import MapKit

class ReceiverTVC: UITableViewCell {
  
  @IBOutlet weak var itemTypeLabel: UILabel!
  @IBOutlet weak var itemDistanceLabel: UILabel!
  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var squareBackgroundView: UIView!
  @IBOutlet weak var itemImage: UIImageView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var favoriteButton: UIButton!
  
  @IBOutlet var staticLabels: [UILabel]!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
  }
}

//MARK: - Setup developer main design
extension ReceiverTVC {
  func setupMainDesign() {
    setupMainContentView()
    setupSquareBackgroundView()
    setupStaticLabels()
    setupItemTypeLabel()
    setupItemDistanceLabel()
    setupItemNameLabel()
    setupDateLabel()
    setupTimeLabel()
    setupMapView()
    setupItemImage()
    setupOutletsCollectionsOrder()
  }
}

//MARK: - Setup main view design
extension ReceiverTVC {
  func setupMainContentView() {
    contentView.setupMainBackgroundColor()
    squareBackgroundView.setupMainBackgroundColor()
  }
}

//MARK: - Setup square background view design
extension ReceiverTVC {
  func setupSquareBackgroundView() {
    squareBackgroundView.backgroundColor = .iceBackground
    squareBackgroundView.layer.cornerRadius = 10
    squareBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    squareBackgroundView.layer.borderWidth = 1
    
  }
}

//MARK: - Setup item type label design
extension ReceiverTVC {
  func setupItemTypeLabel() {
    itemTypeLabel.textAlignment = .center
    itemTypeLabel.setupFont(as: .arialBold, sized: .twenty, forIPad: .twentySeven, in: .typoBlue)
  }
}

//MARK: - Setup item distance label design
extension ReceiverTVC {
  func setupItemDistanceLabel() {
    itemDistanceLabel.setupFont(as: .arial, sized: .heighteen, forIPad: .twentyFive, in: .typoBlue)
  }
}

//MARK: - Setup item name label design
extension ReceiverTVC {
  func setupItemNameLabel() {
    itemNameLabel.setupFont(as: .superclarendonBold, sized: .heighteen, forIPad: .twentySeven, in: .typoBlue)
  }
}

//MARK: - Setup date label design
extension ReceiverTVC {
  func setupDateLabel() {
    dateLabel.setupFont(as: .superclarendonBold, sized: .heighteen, forIPad: .twentySeven, in: .typoBlue)
  }
}

//MARK: - Setup time label design
extension ReceiverTVC {
  func setupTimeLabel() {
    timeLabel.setupFont(as: .superclarendonBold, sized: .heighteen, forIPad: .twentySeven, in: .typoBlue)
  }
}

//MARK: - Setup map view design
extension ReceiverTVC {
  func setupMapView() {
    mapView.layer.cornerRadius = 10
    mapView.isUserInteractionEnabled = false
  }
}

//MARK: - Setup item image design
extension ReceiverTVC {
  func setupItemImage() {
    itemImage.layer.cornerRadius = 3
  }
}

//MARK: - Setup outlet collection to be in order
extension ReceiverTVC {
  func setupOutletsCollectionsOrder() {
    staticLabels = staticLabels.sorted(by: { $0.tag < $1.tag })
  }
}

//MARK: - Setup static labels
extension ReceiverTVC {
  func setupStaticLabels() {
    staticLabels[0].text = StaticItemDetail.type.rawValue
    staticLabels[1].text = StaticItemDetail.the.rawValue
    staticLabels[2].text = StaticItemDetail.at.rawValue
    for label in staticLabels {
      label.setupFont(as: .arial, sized: .seventeen, forIPad: .twentyThree, in: .typoBlue)
    }
  }
}

extension ReceiverTVC {
  func addMeetingPointOnMap(latitude: Double, longitude: Double) {
    let annotation = MKPointAnnotation()
    let locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    annotation.coordinate = locationCoordinates
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotation(annotation)
    
    let coordinate = locationCoordinates
    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
}
