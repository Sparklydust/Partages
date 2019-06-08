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
    senderConversationLabel.textColor = UIColor.iceBackground
    senderConversationLabel.font = UIFont(customFont: .arialBold, withSize: .fifteen)
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
    senderDateLabel.font = UIFont(customFont: .superclarendonBold, withSize: .ten)
    senderDateLabel.textColor = UIColor.typoBlue
  }
}

//MARK: - Setup main developer design
extension SenderTVC {
  func setupMainDesign() {
    setupProfileImage()
    setupDateLabel()
    setupConversationLabel()
    setupConversationView()
  }
}
