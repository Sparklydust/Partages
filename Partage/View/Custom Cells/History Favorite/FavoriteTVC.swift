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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
  }
}

//MARK: Setup top label design
extension FavoriteTVC {
  func setupTopLabel() {
    topLabel.font = UIFont(customFont: .mainAppFont, withSize: .editLabelSize)
    topLabel.textColor = UIColor.typoBlue
  }
}

//MARK: Setup middle label design
extension FavoriteTVC {
  func setupMiddleLabel() {
    middleLabel.font = UIFont(customFont: .mainAppFont, withSize: .editLabelSize)
    middleLabel.textColor = UIColor.typoBlue
  }
}

//MARK: Setup bottom label design
extension FavoriteTVC {
  func setupBottomLabel() {
    bottomLabel.font = UIFont(customFont: .buttonFont, withSize: .editLabelSize)
    bottomLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup main developer design
extension FavoriteTVC {
  func setupMainDesign() {
    setupTopLabel()
    setupMiddleLabel()
    setupBottomLabel()
  }
}
