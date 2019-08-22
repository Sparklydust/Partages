//
//  ButtonName.swift
//  Partage
//
//  Created by Roland Lariotte on 06/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Buttons name
enum ButtonName: String {
  case shareMain
  case receiveMain
  case cancel
  case save
  case signUp
  case signIn
  case lowContactUs
  case lowSignUp
  case lowSignIn
  case lowSignOut
  case lowEraseAccount
  case lowLostPassword
  case send
  case receiveThisDonation
  case messageToReceiver
  case messageToDonor
  case addToCalendar
  case history
  case favorite
  case signInSignUp
  case afterSignedIn
  case donationMade
  case edit
  case done
  case ok
  case settings
  case reset
  case makeADonation
  case saveMeetingPoint
  case setupMeetingPoint
  case changeMeetingPoint
  case confirm
  case emptyString
  case openMapApp
  case modifyDonation

  var description: String {
    get {
      switch(self) {
      case .shareMain:
        return LocalizableStrings.shareMain
      case .receiveMain:
        return LocalizableStrings.receiveMain
      case .cancel:
        return LocalizableStrings.cancel
      case .save:
        return LocalizableStrings.save
      case .signUp:
        return LocalizableStrings.signUp
      case .signIn:
        return LocalizableStrings.signIn
      case .lowContactUs:
        return LocalizableStrings.lowContactUs
      case .lowSignUp:
        return LocalizableStrings.lowSignUp
      case .lowSignIn:
        return LocalizableStrings.lowSignIn
      case .lowSignOut:
        return LocalizableStrings.lowSignOut
      case .lowEraseAccount:
        return LocalizableStrings.lowEraseAccount
      case .lowLostPassword:
        return LocalizableStrings.lowLostPassword
      case .send:
        return LocalizableStrings.send
      case .receiveThisDonation:
        return LocalizableStrings.receiveThisDonation
      case .messageToReceiver:
        return LocalizableStrings.messageToReceiver
      case .messageToDonor:
        return LocalizableStrings.messageToDonor
      case .addToCalendar:
        return LocalizableStrings.addToCalendar
      case .history:
        return LocalizableStrings.history
      case .favorite:
        return LocalizableStrings.favorite
      case .signInSignUp:
        return LocalizableStrings.signInSignUp
      case .afterSignedIn:
        return LocalizableStrings.afterSignedIn
      case .donationMade:
        return LocalizableStrings.donationMade
      case .edit:
        return LocalizableStrings.edit
      case .done:
        return LocalizableStrings.done
      case .ok:
        return LocalizableStrings.ok
      case .settings:
        return LocalizableStrings.settings
      case .reset:
        return LocalizableStrings.reset
      case .makeADonation:
        return LocalizableStrings.makeADonation
      case .saveMeetingPoint:
        return LocalizableStrings.saveMeetingPoint
      case .setupMeetingPoint:
        return LocalizableStrings.setupMeetingPoint
      case .changeMeetingPoint:
        return LocalizableStrings.changeMeetingPoint
      case .confirm:
        return LocalizableStrings.confirm
      case .emptyString:
        return LocalizableStrings.emptyString
      case .openMapApp:
        return LocalizableStrings.openMapApp
      case .modifyDonation:
        return LocalizableStrings.modifyDonation
      }
    }
  }
}
