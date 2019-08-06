//
//  UserDefaultsServiceTest.swift
//  PartageTests
//
//  Created by Roland Lariotte on 02/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
@testable import Partage
import Foundation

class UserDefaultsServiceTest: XCTestCase {
  
  var sut: UserDefaultsService!
  var fakeSettingsContainer: FakeSettingsContainer!
  
  let token = "lNYtDitHSaiFb7KeVQOcg=="
  let userID = "52078C28-0CA3-4B32-A7F2-E3E52F3A2D9A"
  
  override func setUp() {
    super.setUp()
    fakeSettingsContainer = FakeSettingsContainer()
    sut = UserDefaultsService(settingsContainer: fakeSettingsContainer)
  }
  
  override func tearDown() {
    sut = nil
    fakeSettingsContainer = nil
    super.tearDown()
  }
  
  func testUserDefaultsWhenTokenIsStore() {
    //Given
    sut.token = token
    //When
    let userToken = sut.token
    //Then
    XCTAssertEqual(userToken, token)
  }
  
  func testUserLogoutDeleteUserDefaultsToken() {
    //Given
    sut.token = nil
    //When
    let userToken = token
    //Then
    XCTAssertNotEqual(userToken, sut.token)
  }
  
  func testUserDefaultsWhenUserIdIsStore() {
    //Given
    sut.userID = userID
    //When
    let user = sut.userID
    //Then
    XCTAssertEqual(user, userID)
  }
  
  func testUserLogoutDeleteUserDefaultsUserId() {
    //Given
    sut.userID = nil
    //When
    let user = userID
    //Then
    XCTAssertNotEqual(user, sut.userID)
  }
}
