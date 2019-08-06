//
//  FakeResponseData.swift
//  PartageTests
//
//  Created by Roland Lariotte on 02/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Fake Response data for testing ResourceRequest
class FakeResponseData {
  static let response200OK = HTTPURLResponse(url: URL(string: "https://localhost/8080")!,
                                   statusCode: 200, httpVersion: nil, headerFields: nil)!
  static let response201OK = HTTPURLResponse(url: URL(string: "https://localhost/8080")!,
                                   statusCode: 201, httpVersion: nil, headerFields: nil)!
  static let response204OK = HTTPURLResponse(url: URL(string: "https://localhost/8080")!,
                                   statusCode: 204, httpVersion: nil, headerFields: nil)!
  static let responseKO = HTTPURLResponse(url: URL(string: "https://localhost/8080")!,
                                   statusCode: 500, httpVersion: nil, headerFields: nil)!
  
  //Fake error response
  class RessourceError: Error {}
  static let error = RessourceError()
  
  //Bundle to get the fake PublicUser response data
  static var PublicUserCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let urlPublicUser = bundle.url(forResource: "PublicUser", withExtension: "json")
    let dataPublicUser = try! Data(contentsOf: urlPublicUser!)
    return dataPublicUser
  }
  
  //Bundle to get the fake FullUser response data
  static var FullUserCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let urlFullUser = bundle.url(forResource: "FullUser", withExtension: "json")
    let dataFullUser = try! Data(contentsOf: urlFullUser!)
    return dataFullUser
  }
  
  //Bundle to get the fake DonatedItem response data
  static var DonatedItemCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let urlDonatedItems = bundle.url(forResource: "DonatedItem", withExtension: "json")
    let dataDonatedItems = try! Data(contentsOf: urlDonatedItems!)
    return dataDonatedItems
  }
  
  //Bundle to get the fake DonatedItems response data
  static var DonatedItemsArrayCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let urlDonatedItems = bundle.url(forResource: "DonatedItemsArray", withExtension: "json")
    let dataDonatedItems = try! Data(contentsOf: urlDonatedItems!)
    return dataDonatedItems
  }
  
  //Getting the wrong data back from fake web service call
  static let ResourceIncorrectData = "error".data(using: .utf8)!
  
  //Getting the wrong image data back from fake web service call
  static let imageData = "image".data(using: .utf8)!
}
