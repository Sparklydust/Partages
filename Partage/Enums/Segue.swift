//
//  SegueIdentifier.swift
//  Partage
//
//  Created by Roland Lariotte on 11/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - All segue identifiers
enum Segue: String {
  case goesToDonatorVC = "goToDonatorVC"
  case goesToSignInSignUpVC = "goToSignInSignUpVC"
  case goesToReceiverVC = "goToReceiverVC"
  case goesToChatMessageVC = "goToChatMessageVC"
  case goesToItemDetailsVC = "goToItemDetailsVC"
  case goesToItemImagesVC = "goToItemImagesVC"
  case goesToItemSelectedVC = "goToItemSelectedVC"
  case goesToMapViewVC = "goToMapViewVC"
  case goesToSignUpVC = "goToSignUpVC"
  case goesToSignInVC = "goToSignInVC"
  case goesToEditProfile = "goToEditProfile"
  case unwindsToSharingVC = "unwindToSharingVC"
  case unwindsToSignInVC = "unwindToSignInVC"
  case unwindToHistoryFavoriteVC = "unwindToHistoryFavoriteVC"
  case unwindToMessageVC = "unwindToMessageVC"
}
