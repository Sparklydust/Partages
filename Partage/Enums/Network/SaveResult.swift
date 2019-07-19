//
//  SaveResult.swift
//  Partage
//
//  Created by Roland Lariotte on 19/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Used to save user or donated item in the database
enum SaveResult<ResourceType> {
  case success(ResourceType)
  case failure
}
