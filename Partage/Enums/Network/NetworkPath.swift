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
  case mainPath = "http://192.168.1.61:8080/api/"
  case login = "login/"
  case users = "users/"
  case user = "user/"
  case myAccount = "users/myAccount/"
  case editAccount = "users/editAccount/"
  case editAccountAndPassord = "users/editAccountAndPassord/"
  case deleteUser = "users/delete/"
  case donatedItems = "donatedItems/"
  case favoritedItemID = "/favoritedItemID"
  case favoritedByUser = "favoritedByUser/"
  case itemsFavorited = "itemsFavorited"
  case isReceivedBy = "isReceivedBy/"
  case isPickedUp = "isPickedUp"
  case messages = "messages/"
  case ofUser = "ofUser/"
  case chatMessages = "chatMessages/"
}
