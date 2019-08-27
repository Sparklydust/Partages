//
//  StaticLabel.swift
//  Partage
//
//  Created by Roland Lariotte on 06/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - All static label or placeholder name
enum StaticLabel: String {
  case firsName
  case lastName
  case email
  case password
  case newPassword
  case confirmPassword
  case enterYourDonationName
  case enterItemDescription
  case imageLoaderGuide
  case meetingPoint
  case userPosition
  case emptyString
  case dateOccurence
  case receiverCalendarTitle
  case donorCalendarTitle
  case donationIsSelected
  case donationNotSelected
  case userLeftTheConversation
  case closedConversation
  case stringTokenFormat
  case apiService
  case plist

  var description: String {
    get {
      switch(self) {
      case .firsName:
        return LocalizableStrings.firsName
      case .lastName:
        return LocalizableStrings.lastName
      case .email:
        return LocalizableStrings.email
      case .password:
        return LocalizableStrings.password
      case .newPassword:
        return LocalizableStrings.newPassword
      case .confirmPassword:
        return LocalizableStrings.confirmPassword
      case .enterYourDonationName:
        return LocalizableStrings.enterYourDonationName
      case .enterItemDescription:
        return LocalizableStrings.enterItemDescription
      case .imageLoaderGuide:
        return LocalizableStrings.imageLoaderGuide
      case .meetingPoint:
        return LocalizableStrings.meetingPoint
      case .userPosition:
        return LocalizableStrings.userPosition
      case .emptyString:
        return LocalizableStrings.emptyString
      case .dateOccurence:
        return LocalizableStrings.dateOccurence
      case .receiverCalendarTitle:
        return LocalizableStrings.receiverCalendarTitle
      case .donorCalendarTitle:
        return LocalizableStrings.donorCalendarTitle
      case .donationIsSelected:
        return LocalizableStrings.donationIsSelected
      case .donationNotSelected:
        return LocalizableStrings.donationNotSelected
      case .userLeftTheConversation:
        return LocalizableStrings.userLeftTheConversation
      case .closedConversation:
        return LocalizableStrings.closedConversation
      case .stringTokenFormat:
        return LocalizableStrings.stringTokenFormat
      case .apiService:
        return LocalizableStrings.apiService
      case .plist:
        return LocalizableStrings.plist
      }
    }
  }
}
