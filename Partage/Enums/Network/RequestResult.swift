//
//  RequestResult.swift
//  Partage
//
//  Created by Roland Lariotte on 24/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Check if a result is success or not
enum RequestResult {
  case success
  case failure
}

//MARK: - Check resource type request result
enum RequestOneResult<ResourceType> {
  case success(ResourceType)
  case failure
}

//MARK: - Return the result of an array result
enum RequestArrayResult<ResourceType> {
  case success([ResourceType])
  case failure
}
