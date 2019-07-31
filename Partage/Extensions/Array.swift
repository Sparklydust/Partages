//
//  Array.swift
//  Partage
//
//  Created by Roland Lariotte on 31/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Used to get UIViewController position to find its previous one
extension Array where Iterator.Element == UIViewController {
  var previous: UIViewController? {
    if self.count >= 1 {
      return self[self.count - 1]
    }
    return nil
  }
}
