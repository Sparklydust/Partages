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
  
  @IBOutlet weak var barDesignView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
  }
}

//MARK: Setup top label design
extension FavoriteTVC {
  func setupTopLabel() {
    topLabel.font = UIFont(customFont: .superclarendonBold, withSize: .fifteen)
    topLabel.textColor = UIColor.typoBlue
  }
}

//MARK: Setup middle label design
extension FavoriteTVC {
  func setupMiddleLabel() {
    middleLabel.font = UIFont(customFont: .superclarendonBold, withSize: .fifteen)
    middleLabel.textColor = UIColor.typoBlue
  }
}

//MARK: Setup bottom label design
extension FavoriteTVC {
  func setupBottomLabel() {
    bottomLabel.font = UIFont(customFont: .arialBlack, withSize: .fifteen)
    bottomLabel.textColor = UIColor.typoBlue
  }
}

extension FavoriteTVC {
  func setupBarDesignView() {
    barDesignView.backgroundColor = UIColor.mainBlue
  }
}

//MARK: - Setup main developer design
extension FavoriteTVC {
  func setupMainDesign() {
    setupTopLabel()
    setupMiddleLabel()
    setupBottomLabel()
    setupBarDesignView()
  }
}
