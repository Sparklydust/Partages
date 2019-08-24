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
  let deviceToken = "90fae728e65a5a0f4ba3e55f09ab5baac117516c697c0b536ea4feb5cd4fb83d"
  let actionCount = 3
  
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
    sut.userToken = token
    //When
    let userToken = sut.userToken
    //Then
    XCTAssertEqual(userToken, token)
  }
  
  func testUserLogoutDeleteUserDefaultsToken() {
    //Given
    sut.userToken = nil
    //When
    let userToken = token
    //Then
    XCTAssertNotEqual(userToken, sut.userToken)
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
  
  func testUserDefaultsWhenDeviceTokenIsStored() {
    //Given
    sut.deviceToken = deviceToken
    //When
    let deviceTokenSaved = sut.deviceToken
    //Then
    XCTAssertEqual(deviceTokenSaved, deviceToken)
  }
  
  func testDeletionOfDeviceToken() {
    //Given
    sut.deviceToken = nil
    //When
    let deviceTokenUnsaved = deviceToken
    //Then
    XCTAssertNotEqual(deviceTokenUnsaved, sut.deviceToken)
  }
  
  func testUserDefaultsWhenTrackingUserActionPerformed() {
    //Given
    sut.actionCount = actionCount
    //When
    let actionUserPerformed = sut.actionCount
    //Then
    XCTAssertEqual(actionUserPerformed, actionCount)
  }
  
  func testCounterGoesBackToNilWhenUserReachedIt() {
    //Given
    sut.actionCount = nil
    //When
    let actionUserPerformed = actionCount
    //Then
    XCTAssertNotEqual(actionUserPerformed, sut.actionCount)
  }
}
