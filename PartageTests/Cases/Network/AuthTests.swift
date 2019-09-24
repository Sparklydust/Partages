//
//  Auth.swift
//  PartageTests
//
//  Created by Roland Lariotte on 02/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
@testable import Partages

class AuthTest: XCTestCase {
  var loginUser: FullUser!
  
  override func setUp() {
    super.setUp()
    loginUser = FullUser(appleID: "appleID",
                         firstName: "Abcom",
                         lastName: "",
                         email: "a@b.com",
                         password: "123456"
    )
  }
  
  override func tearDown() {
    loginUser = nil
    super.tearDown()
  }
}

extension AuthTest {
  func testUserLoginShouldPostFailureIfError() {
    //Given
    let authRequest = Auth(authSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    authRequest.login(email: loginUser.email, password: loginUser.password!) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success:
        XCTAssertNil(success)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUserLoginShouldPostFailureIfNoData() {
    //Given
    let authRequest = Auth(authSession: URLSessionFake(data: nil, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    authRequest.login(email: loginUser.email, password: loginUser.password!) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success:
        XCTAssertNil(success)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUserLoginShouldPostFailureIfIncorrectResponse() {
    //Given
    let authRequest = Auth(authSession: URLSessionFake(data: FakeResponseData.FullUserCorrectData, response: FakeResponseData.responseKO, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    authRequest.login(email: loginUser.email, password: loginUser.password!) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success:
        XCTAssertNil(success)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUserLoginShouldPostFailureIfIncorrectData() {
    //Given
    let authRequest = Auth(authSession: URLSessionFake(data: FakeResponseData.ResourceIncorrectData, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    authRequest.login(email: loginUser.email, password: loginUser.password!) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success:
        XCTAssertNil(success)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUserLoginShouldPostSuccessIfNoErrorAndCorrectData() {
    //Given
    let authRequest = Auth(authSession: URLSessionFake(data: FakeResponseData.PublicUserCorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    authRequest.login(email: loginUser.email, password: loginUser.password!) { (success) in
      //Then
      XCTAssertNotNil(success)
      switch success {
      case .failure:
        XCTAssert(false, "success should not retun a failure")
      case .success:
        XCTAssert(true)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
}
