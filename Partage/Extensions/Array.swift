//
//  Array.swift
//  Partage
//
//  Created by Roland Lariotte on 31/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - Used to get UIViewController position to find its previous one
extension Array where Iterator.Element == UIViewController {
  var previous: UIViewController? {
    if self.count >= 1 {
      return self[self.count - 1]
    }
    return nil
  }
}

//MARK: - Used to sort an array of item to the closest from the furthest of the user location
extension Array where Element == DonatedItem {
  mutating func sort(by location: CLLocation) {
    return sort(by: { $0.distance(to: location) < $1.distance(to: location) })
  }

  func sorted(by location: CLLocation) -> [DonatedItem] {
    return sorted(by: { $0.distance(to: location) < $1.distance(to: location) })
  }
}
