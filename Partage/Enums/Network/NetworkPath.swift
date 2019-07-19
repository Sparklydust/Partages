//
//  NetworkPath.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

enum NetworkPath: String {
  case mainPath = "http://localhost:8080/api/"
  case login = "http://localhost:8080/api/users/login"
  case saveUser = "users/"
  case donatedItems = "donatedItems/"
}
