//
//  Encodable.swift
//  Partage
//
//  Created by Roland Lariotte on 08/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Method to save items in as a dictionary
extension Encodable {
  func toDictionary() throws -> [String: Any] {
    let data = try! JSONEncoder().encode(self)
    guard let dict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dict
  }
}
