//
//  NetworkPath.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Network path to reach API requests
enum NetworkPath: String {
  case mainPath
  case login
  case users
  case user
  case myAccount
  case editAccount
  case editAccountAndPassord
  case deleteUser
  case donatedItems
  case favoritedItemID
  case favoritedByUser
  case itemsFavorited
  case isReceivedBy
  case isPickedUp
  case messages
  case ofUser
  case chatMessages

  var description: String {
    get {
      switch(self) {
      case .mainPath:
        return LocalizableStrings.mainPath
      case .login:
        return LocalizableStrings.login
      case .users:
        return LocalizableStrings.users
      case .user:
        return LocalizableStrings.user
      case .myAccount:
        return LocalizableStrings.myAccount
      case .editAccount:
        return LocalizableStrings.editAccount
      case .editAccountAndPassord:
        return LocalizableStrings.editAccountAndPassord
      case .deleteUser:
        return LocalizableStrings.deleteUser
      case .donatedItems:
        return LocalizableStrings.donatedItems
      case .favoritedItemID:
        return LocalizableStrings.favoritedItemID
      case .favoritedByUser:
        return LocalizableStrings.favoritedByUser
      case .itemsFavorited:
        return LocalizableStrings.itemsFavorited
      case .isReceivedBy:
        return LocalizableStrings.isReceivedBy
      case .isPickedUp:
        return LocalizableStrings.isPickedUp
      case .messages:
        return LocalizableStrings.messages
      case .ofUser:
        return LocalizableStrings.ofUser
      case .chatMessages:
        return LocalizableStrings.chatMessages
      }
    }
  }
}
