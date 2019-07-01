//
//  Date.swift
//  Partage
//
//  Created by Roland Lariotte on 01/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Check if date is greater than an another one
extension Date {
  func isGreaterThanDate(dateToCompare: Date) -> Bool {
    var isGreater = false
    //Compare Values
    if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
      isGreater = true
    }
    return isGreater
  }
}

//MARK: - Check if date is less than an another one
extension Date {
  func isLessThanDate(dateToCompare: Date) -> Bool {
    var isLess = false
    //Compare Values
    if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
      isLess = true
    }
    return isLess
  }
}

//MARK: - Check if date is equal to an another one
extension Date {
  func equalToDate(dateToCompare: Date) -> Bool {
    var isEqualTo = false
    //Compare Values
    if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
      isEqualTo = true
    }
    return isEqualTo
  }
}