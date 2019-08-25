//
//  AppStoreReviewHandler.swift
//  Partage
//
//  Created by Roland Lariotte on 24/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import StoreKit

final class AppStoreReviewHandler {
  static let shared = AppStoreReviewHandler()
  
  private let minimumReviewWorthyActionCount = 30
}

//MARK: - Requesting user for a review on Apple Store after minimum user actions performed
extension AppStoreReviewHandler {
  func requestReviewIfAppropriate() {
    var actionCount: Int = UserDefaultsService.shared.actionCount ?? 0
    actionCount += 1
    UserDefaultsService.shared.actionCount = actionCount
    
    guard actionCount >= minimumReviewWorthyActionCount else { return }
    
    SKStoreReviewController.requestReview()
    UserDefaultsService.shared.actionCount = 0
  }
}
