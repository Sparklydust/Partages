//
//  FakeSettingsContainer.swift
//  PartageTests
//
//  Created by Roland Lariotte on 05/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
@testable import Partages

class FakeSettingsContainer: SettingsContainer {
  var userToken: String?
  var userID: String?
  var deviceToken: String?
  var actionCount: Int?
  var appleID: String?
  var signedInWithApple: Bool?
}
