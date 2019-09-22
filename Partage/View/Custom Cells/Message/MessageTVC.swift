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

//MARK: - Setup main developer design
extension MessageTVC {
  func setupMainDesign() {
    setupMainContentView()
    setupProfileImage()
    setupFonts()
  }
}

//MARK: - Setup main view design
extension MessageTVC {
  func setupMainContentView() {
    contentView.setupMainBackgroundColor()
  }
}

//MARK: - Setup all fonts
extension MessageTVC {
  func setupFonts() {
    if let typoBlueDarkModeColor = UIColor.typoBlueDarkMode {
    nameLabel.setupFont(as: .superclarendonBold, sized: .sixteen, forIPad: .twentyThree, in: typoBlueDarkModeColor)
    dateLabel.setupFont(as: .superclarendonLight, sized: .twelve, forIPad: .twenty, in: .middleBlue)
    conversationLabel.setupFont(as: .arial, sized: .fifteen, forIPad: .twentyTwo, in: typoBlueDarkModeColor)
    }
  }
}

//MARK: - Setup profile image
extension MessageTVC {
  func setupProfileImage() {
    profileImage.image = #imageLiteral(resourceName: "noPicture")
    profileImage.roundedWithMainBlueBorder()
  }
}
