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
    setupProfileImage()
    setupFonts()
    setupFontsColor()
  }
}

//MARK: - Setup all fonts
extension MessageTVC {
  func setupFonts() {
    nameLabel.font = UIFont(customFont: .mainAppFont, withSize: .nameLabelSize )
    dateLabel.font = UIFont(customFont: .mainAppFontLight, withSize: .dateLabelSize)
    conversationLabel.font = UIFont(customFont: .messageLabelFont, withSize: .editLabelSize)
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
    profileImage.roundedImageWithMainBlueBorder()
  }
}
