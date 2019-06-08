//
//  MessageTVC.swift
//  Partage
//
//  Created by Roland Lariotte on 03/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class MessageTVC: UITableViewCell {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var conversationLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
  }
}

//MARK: - Setup all fonts
extension MessageTVC {
  func setupFonts() {
    nameLabel.font = UIFont(customFont: .superclarendonBold, withSize: .sixteen )
    dateLabel.font = UIFont(customFont: .superclarendonLight, withSize: .twelve)
    conversationLabel.font = UIFont(customFont: .arial, withSize: .fifteen)
  }
  
  func setupFontsColor() {
    nameLabel.textColor = UIColor.typoBlue
    dateLabel.textColor = UIColor.lightBlue
    conversationLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup profile image
extension MessageTVC {
  func setupProfileImage() {
    profileImage.image = #imageLiteral(resourceName: "noPicture")
    profileImage.roundedWithMainBlueBorder()
  }
}

//MARK: - Setup main developer design
extension MessageTVC {
  func setupMainDesign() {
    setupProfileImage()
    setupFonts()
    setupFontsColor()
  }
}
