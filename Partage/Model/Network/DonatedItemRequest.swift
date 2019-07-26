//
//  DonatedItemRequest.swift
//  Partage
//
//  Created by Roland Lariotte on 19/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

struct DonatedItemRequest {
  let resource: URL
  
  init(donatedItemID: Int) {
    let resourceString = "http://localhost:8080/api/donatedItems/\(donatedItemID)"
    guard let resourceURL = URL(string: resourceString) else {
      fatalError()
    }
    self.resource = resourceURL
  }
}

//MARK: - Get user attached to the donated item
extension DonatedItemRequest {
  func getUser(completion: @escaping (UserRequestResult) -> Void) {
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
}

//MARK: - Update changes of a donated item
extension DonatedItemRequest {
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
}

//MARK: - Delete a donated item
extension DonatedItemRequest {
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

//MARK: - Create a sibling relationship between a donated item and an user that favorites it
extension DonatedItemRequest {
  func linkUserToItemFavorited(_ receiverID: String, completion: @escaping (AuthResult) -> Void) {
    guard let token = UserDefaultsService.token else {
      Auth().logout()
      return
    }
    let url = resource.appendingPathComponent(NetworkPath.favoritedByUser.rawValue).appendingPathComponent("\(receiverID)")
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data , response, _ in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 201  else {
          completion(.failure)
          return
      }
      completion(.success)
    }
    dataTask.resume()
  }
}

//MARK: - Populate the user from an item favorited
extension DonatedItemRequest {
  func populateUserThatFavoritedItem(completion: @escaping (GetResourcesRequest<User>) -> Void) {
    guard let token = UserDefaultsService.token else {
      Auth().logout()
      return
    }
    let url = resource.appendingPathComponent(NetworkPath.favoritedByUser.rawValue)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let users = try decoder.decode([User].self, from: jsonData)
        completion(.success(users))
      } catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}

//MARK: - Delete a link between an user and his favorited item
extension DonatedItemRequest {
  func deleteLinkBetweenUserAndItemFavorited(_ receiverID: String, completion: @escaping (AuthResult) -> Void) {
    guard let token = UserDefaultsService.token else {
      Auth().logout()
      return
    }
    let url = resource.appendingPathComponent(NetworkPath.favoritedByUser.rawValue).appendingPathComponent("\(receiverID)")
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data , response, _ in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 204  else {
          completion(.failure)
          return
      }
      completion(.success)
    }
    dataTask.resume()
  }
}
