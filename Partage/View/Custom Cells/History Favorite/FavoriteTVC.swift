//
//  FavoriteTVC.swift
//  Partage
//
//  Created by Roland Lariotte on 06/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class FavoriteTVC: UITableViewCell {
  
  @IBOutlet weak var itemImage: UIImageView!
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var middleLabel: UILabel!
  @IBOutlet weak var bottomLabel: UILabel!
  @IBOutlet weak var underlineView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
    triggerActivityIndicator(false)
  }
}

//MARK: - Setup main developer design
extension FavoriteTVC {
  func setupMainDesign() {
    setupTopLabel()
    setupMiddleLabel()
    setupBottomLabel()
    setupUnderlineView()
    setupMainContentView()
    setupItemImage()
  }
}

//MARK: - Setup main view design
extension FavoriteTVC {
  func setupMainContentView() {
    contentView.setupMainBackgroundColor()
  }
}

//MARK: Setup top label design
extension FavoriteTVC {
  func setupTopLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      topLabel.setupFont(as: .superclarendonBold, sized: .fifteen, forIPad: .twentyTwo, in: darkModeColor)
    }
  }
}

//MARK: Setup middle label design
extension FavoriteTVC {
  func setupMiddleLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      middleLabel.setupFont(as: .superclarendonBold, sized: .fifteen, forIPad: .twentyTwo, in: darkModeColor)
    }
  }
}

//MARK: Setup bottom label design
extension FavoriteTVC {
  func setupBottomLabel() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      bottomLabel.setupFont(as: .arialBlack, sized: .fifteen, forIPad: .twentyTwo, in: darkModeColor)
    }
  }
}

//MARK: - Setup underline view design
extension FavoriteTVC {
  func setupUnderlineView() {
    underlineView.backgroundColor = UIColor.middleBlue
  }
}

//MARK: - Setup item image design
extension FavoriteTVC {
  func setupItemImage() {
    itemImage.layer.cornerRadius = 2
  }
}

//MARK: - Activity Indicator action and setup
extension FavoriteTVC {
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
