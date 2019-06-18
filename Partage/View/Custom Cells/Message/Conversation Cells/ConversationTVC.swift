//
//  ConversationTVC.swift
//  Partage
//
//  Created by Roland Lariotte on 04/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ConversationTVC: UITableViewCell {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var conversationView: UIView!
  @IBOutlet weak var conversationLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
  }
}

//MARK: - Setup main developer design
extension ConversationTVC {
  func setupMainDesign() {
    setupMainContentView()
    setupProfileImage()
    setupDateLabel()
    setupConversationLabel()
    setupConversationView()
  }
}

//MARK: - Setup main view design
extension ConversationTVC {
  func setupMainContentView() {
    contentView.setupMainBackgroundColor()
    conversationView.setupMainBackgroundColor()
  }
}

//MARK: - Setup profile image
extension ConversationTVC {
  func setupProfileImage() {
    profileImage.roundedWithLightBlueBorder()
    profileImage.image = #imageLiteral(resourceName: "noPicture")
  }
}

//MARK: - Setup conversation Label
extension ConversationTVC {
  func setupConversationLabel() {
    conversationLabel.textColor = UIColor.typoBlue
        conversationLabel.font = UIFont(customFont: .arialBold, withSize: .fifteen)
  }
}

//MARK: - Setup conversation View
extension ConversationTVC {
  func setupConversationView() {
    conversationView.layer.cornerRadius = 13
    conversationView.backgroundColor = UIColor.lightBlue
  }
}

//MARK: - Setup date Label
extension ConversationTVC {
  func setupDateLabel() {
    dateLabel.font = UIFont(customFont: .superclarendonBold, withSize: .ten)
    dateLabel.textColor = UIColor.typoBlue
  }
}
