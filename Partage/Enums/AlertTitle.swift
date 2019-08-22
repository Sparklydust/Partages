//
//  AlertTitle.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - UIAlert title
enum AlertTitle: String {
  case addToCalendarTitle
  case resetTitle
  case locationOffTitle
  case errorTitle
  case successTitle
  case cameraUseTitle
  case restrictedTitle
  case contactUsTitle
  case contactUsCanceledTitle
  case contactUsFailedTitle
  case contactUsSavedTitle
  case contactUsSentTitle
  case emptyCaseTitle
  case thankYouTitle
  case firstNameErrorTitle
  case emailErrorTitle
  case passwordErrorTitle
  case loginErrorTitle
  case userDeletedTitle
  case itemUnselectableTitle
  case itemSelectedTitle

  var description: String {
    get {
      switch(self) {
      case .addToCalendarTitle:
        return LocalizableStrings.addToCalendar
      case .resetTitle:
        return LocalizableStrings.reset
      case .locationOffTitle:
        return LocalizableStrings.locationOffTitle
      case .errorTitle:
        return LocalizableStrings.errorTitle
      case .successTitle:
        return LocalizableStrings.successTitle
      case .cameraUseTitle:
        return LocalizableStrings.cameraUseTitle
      case .restrictedTitle:
        return LocalizableStrings.restrictedTitle
      case .contactUsTitle:
        return LocalizableStrings.contactUsTitle
      case .contactUsCanceledTitle:
        return LocalizableStrings.contactUsCanceledTitle
      case .contactUsFailedTitle:
        return LocalizableStrings.contactUsFailedTitle
      case .contactUsSavedTitle:
        return LocalizableStrings.contactUsSavedTitle
      case .contactUsSentTitle:
        return LocalizableStrings.contactUsSentTitle
      case .emptyCaseTitle:
        return LocalizableStrings.emptyCaseTitle
      case .thankYouTitle:
        return LocalizableStrings.thankYouTitle
      case .firstNameErrorTitle:
        return LocalizableStrings.firstNameErrorTitle
      case .emailErrorTitle:
        return LocalizableStrings.emailErrorTitle
      case .passwordErrorTitle:
        return LocalizableStrings.passwordErrorTitle
      case .loginErrorTitle:
        return LocalizableStrings.loginErrorTitle
      case .userDeletedTitle:
        return LocalizableStrings.userDeletedTitle
      case .itemUnselectableTitle:
        return LocalizableStrings.itemUnselectableTitle
      case .itemSelectedTitle:
        return LocalizableStrings.itemSelectedTitle
      }
    }
  }
}
