//
//  ResourceRequestTest+GET.swift
//  PartageTests
//
//  Created by Roland Lariotte on 02/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
@testable import Partage

class ResourceRequestTest_GET: XCTestCase {
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
extension ResourceRequestTest_GET {
  func testGetResourceShouldPostFailureIfError() {
    //Given
    let resourceRequest = ResourceRequest<User>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.get(tokenNeeded: true) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let user):
        XCTAssertNil(user)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetResourceShouldPostFailureIfNoData() {
    //Given
    let resourceRequest = ResourceRequest<User>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.get(tokenNeeded: false) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let user):
        XCTAssertNil(user)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetResourceShouldPostFailureIfIncorrectResponse() {
    //Given
    let resourceRequest = ResourceRequest<FullUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.FullUserCorrectData, response: FakeResponseData.responseKO, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.get(tokenNeeded: false) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should return a failure")
      case .success(let fullUser):
        XCTAssertNil(fullUser)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetResourceShouldPostFailureIfIncorrectData() {
    //Given
    let resourceRequest = ResourceRequest<User>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.ResourceIncorrectData, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.get(tokenNeeded: false) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let user):
        XCTAssertNil(user)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetResourceShouldPostSuccessIfNoErrorAndCorrectData() {
    //Given
    let resourceRequest = ResourceRequest<User>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.FullUserCorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.get(tokenNeeded: false) { (success) in
      //Then
      let id = "52078C28-0CA3-4B32-A7F2-E3E52F3A2D9A"
      let firstName = "Abcom"
      
      XCTAssertNotNil(success)
      switch success {
      case .failure:
        XCTAssert(false, "success should not retun a failure")
      case .success(let user):
        XCTAssertNotNil(user)
        XCTAssertEqual(id, user.id?.uuidString)
        XCTAssertEqual(firstName, user.firstName)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
}

//MARK: - Testing the get all resources request
extension ResourceRequestTest_GET {
  func testGetAllResourcesShouldPostFailureIfError() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.getAll(tokenNeeded: true) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let donatedItems):
        XCTAssertNil(donatedItems)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetAllResourcesShouldPostFailureIfNoData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.getAll(tokenNeeded: false) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let donatedItems):
        XCTAssertNil(donatedItems)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetAllResourceShouldPostFailureIfIncorrectResponse() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.DonatedItemsArrayCorrectData, response: FakeResponseData.responseKO, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.getAll(tokenNeeded: true) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let donatedItems):
        XCTAssertNil(donatedItems)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetAllResourcesShouldPostFailureIfIncorrectData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.ResourceIncorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.getAll(tokenNeeded: false) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let donatedItems):
        XCTAssertNil(donatedItems)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testGetAllResourcesShouldPostSuccessIfNoErrorAndCorrectData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.DonatedItemsArrayCorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.getAll(tokenNeeded: true) { (success) in
      //Then
      let Item1_pickUpDateTime = "2019-08-11T09:55:09+02:00"
      let Item1_latitude = 45.068328488369275
      let Item1_description = "Oc Pizza Tournon"

      let Item3_isPicked = false
      let Item3_selectedType = "Vêtement"
      let Item3_name = "T-shirt Volcom"

      switch success {
      case .failure:
        XCTAssert(false, "success should not return a failure")
      case .success(let donatedItems):
        XCTAssertNotNil(donatedItems)
        XCTAssertEqual(Item1_pickUpDateTime, donatedItems[0].pickUpDateTime)
        XCTAssertEqual(Item1_latitude, donatedItems[0].latitude )
        XCTAssertEqual(Item1_description, donatedItems[0].description )

        XCTAssertEqual(Item3_isPicked, donatedItems[2].isPicked)
        XCTAssertEqual(Item3_selectedType, donatedItems[2].selectedType )
        XCTAssertEqual(Item3_name, donatedItems[2].name )
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
}
