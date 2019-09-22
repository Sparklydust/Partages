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
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  @IBOutlet var staticLabels: [UILabel]!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
    triggerActivityIndicator(false)
    LocationHandler.shared.checkLocationAuthorization(for: mapView, vc: ReceiverVC.init())
  }
}

//MARK: - Favorite Button action clicked
extension ReceiverTVC {
   @IBAction func favoriteButtonAction(_ sender: Any) {}
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
    setupFavoriteButton()
  }
}

//MARK: - Setup main view design
extension ReceiverTVC {
  func setupMainContentView() {
    contentView.setupMainBackgroundColor()
    squareBackgroundView.setupMainBackgroundColor()
  }
}

//MARK: - Setup favorite button
extension ReceiverTVC {
  func setupFavoriteButton() {
    favoriteButton.isEnabled = false
    favoriteButton.adjustsImageWhenDisabled = false
  }
}

//MARK: - Setup square background view design
extension ReceiverTVC {
  func setupSquareBackgroundView() {
    squareBackgroundView.backgroundColor = .iceBackgroundDarkMode
    squareBackgroundView.layer.cornerRadius = 10
    squareBackgroundView.layer.borderColor = UIColor.mainBlue.cgColor
    squareBackgroundView.layer.borderWidth = 1
    
  }
}

//MARK: - Setup item type label design
extension ReceiverTVC {
  func setupItemTypeLabel() {
    itemTypeLabel.textAlignment = .center
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemTypeLabel.setupFont(as: .arialBold, sized: .heighteen, forIPad: .twentyFive, in: darkModeColor)
    }
  }
}

//MARK: - Setup item distance label design
extension ReceiverTVC {
  func setupItemDistanceLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemDistanceLabel.setupFont(as: .arial, sized: .heighteen, forIPad: .twentyFive, in: darkModeColor)
    }
  }
}

//MARK: - Setup item name label design
extension ReceiverTVC {
  func setupItemNameLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      itemNameLabel.setupFont(as: .superclarendonBold, sized: .twentyTwo, forIPad: .twentyFive, in: darkModeColor)
    }
  }
}

//MARK: - Setup date label design
extension ReceiverTVC {
  func setupDateLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      dateLabel.setupFont(as: .superclarendonBold, sized: .heighteen, forIPad: .twentySeven, in: darkModeColor)
    }
  }
}

//MARK: - Setup time label design
extension ReceiverTVC {
  func setupTimeLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      timeLabel.setupFont(as: .superclarendonBold, sized: .heighteen, forIPad: .twentySeven, in: darkModeColor)
    }
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
    staticLabels[0].text = StaticLabel.emptyString.description
    staticLabels[1].text = StaticLabel.emptyString.description
    staticLabels[2].text = StaticLabel.emptyString.description
    for label in staticLabels {
      if let darkModeColor = UIColor.typoBlueDarkMode {
        label.setupFont(as: .arial, sized: .seventeen, forIPad: .twentyThree, in: darkModeColor)
      }
    }
  }
}

//MARK: - To add the meeting point shown on the map
extension ReceiverTVC {
  func showLocationSurrounding(latitude: Double, longitude: Double) {
    let locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.00085, longitudeDelta: 0.00099)
    let region = MKCoordinateRegion(center: locationCoordinates, span: span)
    mapView.setRegion(region, animated: true)
  }
}

//MARK: - Activity Indicator action and setup
extension ReceiverTVC {
  func triggerActivityIndicator(_ action: Bool) {
    guard action else {
      hideActivityIndicator()
      return
    }
    showActivityIndicator()
  }
  
  func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.color = .mainBlue
    contentView.addSubview(activityIndicator)
    activityIndicator.startAnimating()
  }
  
  func hideActivityIndicator() {
    activityIndicator.isHidden = true
  }
}
