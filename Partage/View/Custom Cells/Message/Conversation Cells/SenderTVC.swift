//
//  SenderTVC.swift
//  Partage
//
//  Created by Roland Lariotte on 04/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SenderTVC: UITableViewCell {
  
  @IBOutlet weak var senderProfileImage: UIImageView!
  @IBOutlet weak var senderConversationView: UIView!
  @IBOutlet weak var senderConversationLabel: UILabel!
  @IBOutlet weak var senderDateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainDesign()
  }
}

//MARK: - Setup main developer design
extension SenderTVC {
  func setupMainDesign() {
    setupMainContentView()
    setupProfileImage()
    setupDateLabel()
    setupConversationLabel()
    setupConversationView()
  }
}

//MARK: - Setup main view design
extension SenderTVC {
  func setupMainContentView() {
    contentView.setupMainBackgroundColor()
    senderConversationView.setupMainBackgroundColor()
  }
}

//MARK: - Setup profile image
extension SenderTVC {
  func setupProfileImage() {
    senderProfileImage.roundedWithMainBlueBorder()
    senderProfileImage.image = #imageLiteral(resourceName: "noPicture")
  }
}

//MARK: - Setup conversation Label
extension SenderTVC {
  func setupConversationLabel() {
    senderConversationLabel.setupFont(as: .arialBold, sized: .fifteen, forIPad: .twentyTwo, in: .iceBackground)
  }
}

//MARK: - Setup conversation View
extension SenderTVC {
  func setupConversationView() {
    senderConversationView.layer.cornerRadius = 13
    senderConversationView.backgroundColor = UIColor.mainBlue
  }
}

//MARK: - Setup date Label
extension SenderTVC {
  func setupDateLabel() {
    senderDateLabel.setupFont(as: .superclarendonBold, sized: .ten, forIPad: .seventeen, in: .typoBlue)
  }
}
