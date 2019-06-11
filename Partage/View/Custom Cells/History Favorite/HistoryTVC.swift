//
//  HistoryTVC.swift
//  Partage
//
//  Created by Roland Lariotte on 06/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class HistoryTVC: UITableViewCell {
  
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
extension HistoryTVC {
  func setupTopLabel() {
    topLabel.font = UIFont(customFont: .superclarendonBold, withSize: .fifteen)
    topLabel.textColor = UIColor.typoBlue
  }
}

//MARK: Setup middle label design
extension HistoryTVC {
  func setupMiddleLabel() {
    middleLabel.font = UIFont(customFont: .superclarendonBold, withSize: .fifteen)
    middleLabel.textColor = UIColor.typoBlue
  }
}

//MARK: Setup bottom label design
extension HistoryTVC {
  func setupBottomLabel() {
    bottomLabel.font = UIFont(customFont: .arialBlack, withSize: .fifteen)
    bottomLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup bar design view
extension HistoryTVC {
  func setupBarDesignView() {
    barDesignView.backgroundColor = UIColor.middleBlue
  }
}

//MARK: - Setup main developer design
extension HistoryTVC {
  func setupMainDesign() {
    setupTopLabel()
    setupMiddleLabel()
    setupBottomLabel()
    setupBarDesignView()
  }
}
