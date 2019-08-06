//
//  ResourceRequestTest+PUT.swift
//  PartageTests
//
//  Created by Roland Lariotte on 02/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
@testable import Partage

class ResourceRequestTest_PUT: XCTestCase {
  var resourcePath: String!
  var userToUpdate: FullUser!
  var itemToUpdate: DonatedItem!
  
  override func setUp() {
    super.setUp()
    resourcePath = "xctest/fake/networkPath/"
    userToUpdate = FullUser(firstName: "Abcom",
                            lastName: "",
                            email: "a@b.com",
                            password: "123456"
    )
    itemToUpdate = DonatedItem(isPicked: false,
                             selectedType: "Nourriture",
                             name: "Pizza",
                             pickUpDateTime: "2019-08-11T09:55:09+02:00",
                             description: "Oc Pizza Tournon",
                             latitude: 45.068328488369275,
                             longitude: 4.8286895335585029
    )
  }
  
  override func tearDown() {
    resourcePath = nil
    userToUpdate = nil
    itemToUpdate = nil
    super.tearDown()
  }
}

//MARK: - Testing the post resource request
extension ResourceRequestTest_PUT {
  func testUpdateResourceShouldPostFailureIfError() {
    //Given
    let resourceRequest = ResourceRequest<FullUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.update(userToUpdate, tokenNeeded: true) { (result) in
      //Then
      switch result {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let updatedUser):
        XCTAssertNil(updatedUser)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUpdateResourceShouldPostFailureIfNoData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.update(itemToUpdate, tokenNeeded: false) { (success) in
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let updatedItem):
        XCTAssertNil(updatedItem)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUpdateResourceShouldPostFailureIfIncorrectResponse() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.DonatedItemCorrectData, response: FakeResponseData.responseKO, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.update(itemToUpdate, tokenNeeded: false) { (success) in
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let updatedItem):
        XCTAssertNil(updatedItem)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUpdateResourceShouldPostFailureIfIncorrectData() {
    //Given
    let resourceRequest = ResourceRequest<FullUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.ResourceIncorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.update(userToUpdate, tokenNeeded: true) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let updatedUser):
        XCTAssertNil(updatedUser)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testUpdateResourceShouldPostSuccessIfNoErrorAndCorrectData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.DonatedItemCorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.update(itemToUpdate, tokenNeeded: true) { (success) in
      //Then
      XCTAssertNotNil(success)
      switch success {
      case .failure:
        XCTAssert(false, "success should not retun a failure")
      case .success(let updatedItem):
        XCTAssertEqual(updatedItem.name, self.itemToUpdate.name)
        XCTAssertEqual(updatedItem.latitude, self.itemToUpdate.latitude )
        XCTAssertEqual(updatedItem.description, self.itemToUpdate.description )
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
}
