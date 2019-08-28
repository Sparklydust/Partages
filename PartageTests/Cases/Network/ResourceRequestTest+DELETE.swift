//
//  ResourceRequestTest+DELETE.swift
//  PartageTests
//
//  Created by Roland Lariotte on 02/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
@testable import Partages

class ResourceRequestTest_DELETE: XCTestCase {
  var resourcePath: String!
  
  override func setUp() {
    super.setUp()
    resourcePath = "xctest/fake/networkPath/"
  }
  
  override func tearDown() {
    resourcePath = nil
    super.tearDown()
  }
}

//MARK: - Testing the get resource request
extension ResourceRequestTest_DELETE {
  func testDeleteResourceShouldPostFailureIfError() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.delete(tokenNeeded: true) { (success) in
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
  
  func testDeleteResourceShouldPostFailureIfNoData() {
    //Given
    let resourceRequest = ResourceRequest<User>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.delete(tokenNeeded: true) { (success) in
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
  
  func testGetResourceShouldPostFailureIfIncorrectResponse() {
    //Given
    let resourceRequest = ResourceRequest<User>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.FullUserCorrectData, response: FakeResponseData.responseKO, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.delete(tokenNeeded: true) { (success) in
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
  
  func testDeleteResourceShouldPostFailureIfIncorrectData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.ResourceIncorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.delete(tokenNeeded: false) { (success) in
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
  
  func testDeleteResourceShouldPostSuccessIfNoErrorAndCorrectData() {
    //Given
    let resourceRequest = ResourceRequest<CreateUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.PublicUserCorrectData, response: FakeResponseData.response204OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.delete(tokenNeeded: true) { (success) in
      //Then
      XCTAssertNotNil(success)
      switch success {
      case .failure:
        XCTAssert(false, "success should not retun a failure")
      case .success:
        XCTAssertNotNil(success)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
}
