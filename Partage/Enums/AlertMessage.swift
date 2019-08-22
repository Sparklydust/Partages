//
//  AlertMessage.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Alert message to be displayed on an UIAlert
enum AlertMessage: String {
  case needAccessToCalendar
  case addedToCalendar
  case resetImage
  case locationOff
  case noPictureloaded
  case cameraUse
  case locationIssue
  case getDirectionIssue
  case noDirectionsCalculated
  case restricted
  case contactUs
  case contactUsCanceled
  case contactUsFailed
  case contactUsSaved
  case contactUsSent
  case noImageSelected
  case noItemTypeSelected
  case noItemName
  case noItemDate
  case noMeetingPoint
  case noDescription
  case noImage
  case confirmDonation
  case resetDonation
  case emailAlreadyInUse
  case passwordDoesntMatch
  case addFirstName
  case addEmail
  case passwordTooShort
  case loginError
  case notConnected
  case signUpError
  case networkRequestError
  case userDeleted
  case itemAlreadySelected
  case donatedItemSelected
  case confirmSelection
  case confirmDonatedItemRemoved
  case confirmChanges
  case donatedItemDeleted
  case canNotSendMessage
  case canNotSelectOwnDonation

  var description: String {
    get {
      switch(self) {
      case .needAccessToCalendar:
        return LocalizableStrings.needAccessToCalendar
      case .addedToCalendar:
        return LocalizableStrings.addedToCalendar
      case .resetImage:
        return LocalizableStrings.resetImage
      case .locationOff:
        return LocalizableStrings.locationOff
      case .noPictureloaded:
        return LocalizableStrings.noPictureloaded
      case .cameraUse:
        return LocalizableStrings.cameraUse
      case .locationIssue:
        return LocalizableStrings.locationIssue
      case .getDirectionIssue:
        return LocalizableStrings.getDirectionIssue
      case .noDirectionsCalculated:
        return LocalizableStrings.noDirectionsCalculated
      case .restricted:
        return LocalizableStrings.restricted
      case .contactUs:
        return LocalizableStrings.contactUs
      case .contactUsCanceled:
        return LocalizableStrings.contactUsCanceled
      case .contactUsFailed:
        return LocalizableStrings.contactUsFailed
      case .contactUsSaved:
        return LocalizableStrings.contactUsSaved
      case .contactUsSent:
        return LocalizableStrings.contactUsSent
      case .noImageSelected:
        return LocalizableStrings.noImageSelected
      case .noItemTypeSelected:
        return LocalizableStrings.noItemTypeSelected
      case .noItemName:
        return LocalizableStrings.noItemName
      case .noItemDate:
        return LocalizableStrings.noItemDate
      case .noMeetingPoint:
        return LocalizableStrings.noMeetingPoint
      case .noDescription:
        return LocalizableStrings.noDescription
      case .noImage:
        return LocalizableStrings.noImage
      case .confirmDonation:
        return LocalizableStrings.confirmDonation
      case .resetDonation:
        return LocalizableStrings.resetDonation
      case .emailAlreadyInUse:
        return LocalizableStrings.emailAlreadyInUse
      case .passwordDoesntMatch:
        return LocalizableStrings.passwordDoesntMatch
      case .addFirstName:
        return LocalizableStrings.addFirstName
      case .addEmail:
        return LocalizableStrings.addEmail
      case .passwordTooShort:
        return LocalizableStrings.passwordTooShort
      case .loginError:
        return LocalizableStrings.loginError
      case .notConnected:
        return LocalizableStrings.notConnected
      case .signUpError:
        return LocalizableStrings.signUpError
      case .networkRequestError:
        return LocalizableStrings.networkRequestError
      case .userDeleted:
        return LocalizableStrings.userDeleted
      case .itemAlreadySelected:
        return LocalizableStrings.itemAlreadySelected
      case .donatedItemSelected:
        return LocalizableStrings.donatedItemSelected
      case .confirmSelection:
        return LocalizableStrings.confirmSelection
      case .confirmDonatedItemRemoved:
        return LocalizableStrings.confirmDonatedItemRemoved
      case .confirmChanges:
        return LocalizableStrings.confirmChanges
      case .donatedItemDeleted:
        return LocalizableStrings.donatedItemDeleted
      case .canNotSendMessage:
        return LocalizableStrings.canNotSendMessage
      case .canNotSelectOwnDonation:
        return LocalizableStrings.canNotSelectOwnDonation
      }
    }
  }
}
