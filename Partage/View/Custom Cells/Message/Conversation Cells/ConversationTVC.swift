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

//MARK: - Setup profile image
extension ConversationTVC {
  func setupProfileImage() {
    profileImage.roundedImageWithLightBlueBorder()
    profileImage.image = #imageLiteral(resourceName: "noPicture")
  }
}

//MARK: - Setup conversation Label
extension ConversationTVC {
  func setupConversationLabel() {
    conversationLabel.textColor = UIColor.typoBlue
        conversationLabel.font = UIFont(customFont: .editLabelFont, withSize: .editLabelSize)
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
    dateLabel.font = UIFont(customFont: .mainAppFont, withSize: .smallDateLabelSize)
    dateLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup main developer design
extension ConversationTVC {
  func setupMainDesign() {
    setupProfileImage()
    setupDateLabel()
    setupConversationLabel()
    setupConversationView()
  }
}
