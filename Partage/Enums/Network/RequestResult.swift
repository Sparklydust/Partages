//
//  RequestResult.swift
//  Partage
//
//  Created by Roland Lariotte on 24/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Check the donated user item request result
enum UserRequestResult {
  case success(User)
  case failure
}

//MARK: - Check the donated item request result
enum DonatedItemRequestResult {
  case success(DonatedItem)
  case failure
}

//MARK: - Return the result of an array result
enum GetResourcesRequest<ResourceType> {
  case success([ResourceType])
  case failure
}
