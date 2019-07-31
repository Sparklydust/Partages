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
  
  init(resourcePath: NetworkPath, userID: String) {
    guard let resourceURL = URL(string: baseURL) else { fatalError() }
    self.resourceURL = resourceURL.appendingPathComponent(resourcePath.rawValue + userID)
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
    }
    catch {
      completion(.failure)
    }
  }
}

//MARK: - Retrieve one user with his userID number
extension UserRequest {
  func get(completion: @escaping (UserRequestResult) -> Void) {
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
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}

//MARK: - Delete a user and all related items in cascade
extension UserRequest {
  func delete() {
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "DELETE"
    urlRequest.addValue("Bearer \(UserDefaultsService.token!)", forHTTPHeaderField: "Authorization")
    let dataTask = URLSession.shared.dataTask(with: urlRequest)
    dataTask.resume()
  }
}

//MARK: - Update changes of a donated item
extension UserRequest {
  func update(with updateData: User, completion: @escaping (SaveResult<User>) -> Void) {
    do {
      guard let token = UserDefaultsService.token else { return }
      var urlRequest = URLRequest(url: resourceURL)
      urlRequest.httpMethod = "PUT"
      urlRequest.httpBody = try JSONEncoder().encode(updateData)
      urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
      urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
        guard let httpResponse = response as? HTTPURLResponse else {
          completion(.failure)
          return
        }
        guard httpResponse.statusCode == 200, let jsonData = data else {
          if httpResponse.statusCode == 401 {
            Auth().logout()
          }
          completion(.failure)
          return
        }
        do {
          let user = try JSONDecoder().decode(User.self, from: jsonData)
          completion(.success(user))
        } catch {
          completion(.failure)
        }
      }
      dataTask.resume()
    } catch {
      completion(.failure)
    }
  }
}
