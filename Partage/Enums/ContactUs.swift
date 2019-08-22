//
//  ContactUs.swift
//  Partage
//
//  Created by Roland Lariotte on 27/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Contact us email sender from Mail app attributes
enum ContactUs: String {
  case partageEmail
  case subject
  case messageBody

  var description: String {
    get {
      switch(self) {
      case .partageEmail:
        return LocalizableStrings.partageEmail
      case .subject:
        return LocalizableStrings.subject
      case .messageBody:
        return LocalizableStrings.messageBody
      }
    }
  }
}
