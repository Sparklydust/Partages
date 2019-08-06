//
//  ResourceRequestTest+POST.swift
//  PartageTests
//
//  Created by Roland Lariotte on 02/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
@testable import Partage

class ResourceRequestTest_POST: XCTestCase {
  var resourcePath: String!
  var userToSave: CreateUser!
  var itemToSave: DonatedItem!
  
  override func setUp() {
    super.setUp()
    resourcePath = "xctest/fake/networkPath/"
    userToSave = CreateUser(firstName: "Abcom",
                              lastName: "",
                              email: "a@b.com",
                              password: "123456"
    )
    itemToSave = DonatedItem(isPicked: false,
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
    userToSave = nil
    itemToSave = nil
    super.tearDown()
  }
}

//MARK: - Testing the post resource request
extension ResourceRequestTest_POST {
  func testSaveResourceShouldPostFailureIfError() {
    //Given
    let resourceRequest = ResourceRequest<CreateUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.save(userToSave, tokenNeeded: true) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let newUser):
        XCTAssertNil(newUser)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testSaveResourceShouldPostFailureIfNoData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.save(itemToSave, tokenNeeded: false) { (success) in
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let newItem):
        XCTAssertNil(newItem)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testSaveResourceShouldPostFailureIfIncorrectResponse() {
    //Given
    let resourceRequest = ResourceRequest<CreateUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.FullUserCorrectData, response: FakeResponseData.responseKO, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.save(userToSave, tokenNeeded: true) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let newUser):
        XCTAssertNil(newUser)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testSaveResourceShouldPostFailureIfIncorrectData() {
    //Given
    let resourceRequest = ResourceRequest<CreateUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.ResourceIncorrectData, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.save(userToSave, tokenNeeded: true) { (success) in
      //Then
      switch success {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let newUser):
        XCTAssertNil(newUser)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
  }
  
  func testSaveResourceShouldPostSuccessIfNoErrorAndCorrectData() {
    //Given
    let resourceRequest = ResourceRequest<CreateUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.PublicUserCorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.save(userToSave, tokenNeeded: true) { (success) in
      
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

//MARK: - Testing the link user to resource request
extension ResourceRequestTest_POST {
  func testLinkUserToResourceShouldPostFailureIfError() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.linkToPivot(tokenNeeded: true) { (success) in
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
  
  func testLinkUserToResourceShouldPostFailureIfNoData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: nil, response: nil, error: nil))
    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    resourceRequest.linkToPivot(tokenNeeded: false) { (success) in
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
  
  func testLinkUserToResourceShouldPostFailureIfIncorrectData() {
    //Given
    let resourceRequest = ResourceRequest<DonatedItem>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.ResourceIncorrectData, response: FakeResponseData.response200OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.linkToPivot(tokenNeeded: true) { (success) in
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
  
  func testLinkUserToResourceShouldPostSuccessIfNoErrorAndCorrectData() {
    //Given
    let resourceRequest = ResourceRequest<CreateUser>(
      resourcePath: resourcePath, resourceSession: URLSessionFake(data: FakeResponseData.PublicUserCorrectData, response: FakeResponseData.response201OK, error: nil))
    //When
    let expectation = XCTestExpectation(description: "wait for queue change")
    resourceRequest.linkToPivot(tokenNeeded: true) { (success) in
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
