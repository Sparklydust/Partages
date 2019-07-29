//
//  ResourceRequest.swift
//  Partage
//
//  Created by Roland Lariotte on 19/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

struct ResourceRequest<ResourceType> where ResourceType: Codable {
  
  let baseURL = "http://localhost:8080/api/"
  let resourceURL: URL
  
  init(resourcePath: String) {
    guard let resourceURL = URL(string: baseURL) else {
      fatalError()
    }
    self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
  }
}

//MARK: - Get all items with no token needed
extension ResourceRequest {
  func getAll(completion: @escaping (GetResourcesRequest<ResourceType>) -> Void) {
    let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure)
        return
      }
      do {
        let decoder = JSONDecoder()
        let resources = try decoder.decode([ResourceType].self, from: jsonData)
        completion(.success(resources))
      } catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}

//MARK: - Save to database with token needed
extension ResourceRequest {
  func save(_ resourceToSave: ResourceType, completion: @escaping (SaveResult<ResourceType>) -> Void) {
    do {
      guard let token = UserDefaultsService.token else { return }
      var urlRequest = URLRequest(url: resourceURL)
      urlRequest.httpMethod = "POST"
      urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
      urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      urlRequest.httpBody = try JSONEncoder().encode(resourceToSave)
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
          let resource = try JSONDecoder().decode(ResourceType.self, from: jsonData)
          completion(.success(resource))
        }
        catch {
          completion(.failure)
        }
      }
      dataTask.resume()
    }
    catch {
      completion(.failure)
    }
  }
}

//MARK: - Get all items with token needed
extension ResourceRequest {
  func getAllWithToken(completion: @escaping (GetResourcesRequest<ResourceType>) -> Void) {
    guard let token = UserDefaultsService.token else { return }
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "GET"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure)
        return
      }
      do {
        let decoder = JSONDecoder()
        let resources = try decoder.decode([ResourceType].self, from: jsonData)
        completion(.success(resources))
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}
