//
//  SettingsContainer.swift
//  Partage
//
//  Created by Roland Lariotte on 06/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Container for UserDefaults settings
protocol SettingsContainer {
  var token: String? { get set }
  var userID: String? { get set }
}
