//
//  apiService.swift
//  Partages
//
//  Created by Roland Lariotte on 27/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

// Method that gets the .gitignore API Source from .plist file
func valueInAPIService(named keyname: String) -> String {
  let filePath = Bundle.main.path(
    forResource: StaticLabel.apiService.description,
    ofType: StaticLabel.plist.description)
  let plist = NSDictionary(contentsOfFile: filePath!)
  let value = plist?.object(forKey: keyname) as! String
  return value
}
