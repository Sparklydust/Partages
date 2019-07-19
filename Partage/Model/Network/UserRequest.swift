//
//  UserRequest.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

struct UserRequest<ResourceType> where ResourceType: Codable {
  let baseURL = NetworkPath.mainPath.rawValue
  let resourceURL: URL
  
  init(resourcePath: String) {
    guard let resourceURL = URL(string: baseURL) else { fatalError() }
    self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
  }
  
  init(resourcePath: String, userID: String) {
    guard let resourceURL = URL(string: baseURL) else { fatalError() }
    self.resourceURL = resourceURL.appendingPathComponent(resourcePath + userID)
  }
}

//MARK: - To save a new user to the database
extension UserRequest {
  func save(_ resourceToSave: ResourceType, completion: @escaping (SaveResult<ResourceType>) -> Void) {
    do {
      var urlRequest = URLRequest(url: resourceURL)
      urlRequest.httpMethod = "POST"
      urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
      urlRequest.httpBody = try JSONEncoder().encode(resourceToSave)
      let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
        guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
            completion(.failure)
            return
        }
        completion(.success(resourceToSave))
      }
      dataTask.resume()
    } catch {
      completion(.failure)
    }
  }
}

//MARK: - Retrieve one user with his userID number
extension UserRequest {
  func get(completion: @escaping (DonatedItemUserRequestResult) -> Void) {
    let urlRequest = URLRequest(url: resourceURL)
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure)
        return
      }
      do {
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: jsonData)
        completion(.success(user))
      } catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}
