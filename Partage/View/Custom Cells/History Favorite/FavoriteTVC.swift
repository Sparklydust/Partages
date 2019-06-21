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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
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
    topLabel.setupFont(as: .superclarendonBold, sized: .fifteen, forIPad: .twentyTwo, in: .typoBlue)
  }
}

//MARK: Setup middle label design
extension FavoriteTVC {
  func setupMiddleLabel() {
    middleLabel.setupFont(as: .superclarendonBold, sized: .fifteen, forIPad: .twentyTwo, in: .typoBlue)
  }
}

//MARK: Setup bottom label design
extension FavoriteTVC {
  func setupBottomLabel() {
    bottomLabel.setupFont(as: .arialBlack, sized: .fifteen, forIPad: .twentyTwo, in: .typoBlue)
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
