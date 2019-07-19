//
//  DonatedItemRequest.swift
//  Partage
//
//  Created by Roland Lariotte on 19/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

enum DonatedItemUserRequestResult {
  case success(User)
  case failure
}

enum CategoryAddResult {
  case success
  case failure
}

struct AcronymRequest {
  let resource: URL
  
  init(donatedItemID: Int) {
    let resourceString = "http://localhost:8080/api/donatedItems/\(donatedItemID)"
    guard let resourceURL = URL(string: resourceString) else {
      fatalError()
    }
    self.resource = resourceURL
  }
  
  func getUser(completion: @escaping (DonatedItemUserRequestResult) -> Void) {
    let url = resource.appendingPathComponent("user")
    let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
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
  
  func update(with updateData: DonatedItem, completion: @escaping (SaveResult<DonatedItem>) -> Void) {
    do {
      guard let token = UserDefaultsService.token else {
        Auth().logout()
        return
      }
      var urlRequest = URLRequest(url: resource)
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
          let donatedItem = try JSONDecoder().decode(DonatedItem.self, from: jsonData)
          completion(.success(donatedItem))
        } catch {
          completion(.failure)
        }
      }
      dataTask.resume()
    } catch {
      completion(.failure)
    }
  }
  
  func delete() {
    guard let token = UserDefaultsService.token else {
      Auth().logout()
      return
    }
    var urlRequest = URLRequest(url: resource)
    urlRequest.httpMethod = "DELETE"
    urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    let dataTask = URLSession.shared.dataTask(with: urlRequest)
    dataTask.resume()
  }
}