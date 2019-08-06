//
//  ResourceRequest.swift
//  Partage
//
//  Created by Roland Lariotte on 19/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

//MARK: - Responsible for making network request
struct ResourceRequest<ResourceType> where ResourceType: Codable {
  
  private let baseURL = NetworkPath.mainPath.rawValue
  private let resourceURL: URL
  
  private var resourceSession = URLSession(configuration: .default)
  //private var imageSession = URLSession(configuration: .default)
  
  init(_ resourcePath: String) {
    guard let resourceURL = URL(string: baseURL) else {
      fatalError()
    }
    self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
  }
  
  //Init for fake resource session testing purposes
  init(resourcePath: String, resourceSession: URLSession) {
    guard let resourceURL = URL(string: baseURL) else {
      fatalError()
    }
    self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
    self.resourceSession = resourceSession
  }
}

//MARK: - Get one resource with no token needed
extension ResourceRequest {
  func get(tokenNeeded: Bool, _ completion: @escaping (RequestOneResult<ResourceType>) -> Void) {
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "GET"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if tokenNeeded {
      guard let token = UserDefaultsService.shared.token else { return }
      urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    let dataTask = resourceSession.dataTask(with: urlRequest) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse else {
        return completion(.failure)
      }
      guard httpResponse.statusCode == 200, let jsonData = data else {
        return completion(.failure)
      }
      do {
        let decoder = JSONDecoder()
        let resources = try decoder.decode(ResourceType.self, from: jsonData)
        completion(.success(resources))
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}

//MARK: - Get array of resources
extension ResourceRequest {
  func getAll(tokenNeeded: Bool, _ completion: @escaping (RequestArrayResult<ResourceType>) -> Void) {
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "GET"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if tokenNeeded {
      guard let token = UserDefaultsService.shared.token else { return }
      urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    let dataTask = resourceSession.dataTask(with: urlRequest) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse else {
        return completion(.failure)
      }
      guard httpResponse.statusCode == 200, let jsonData = data else {
        return completion(.failure)
      }
      do {
        let resources = try JSONDecoder().decode([ResourceType].self, from: jsonData)
        completion(.success(resources))
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}

//MARK: - Save one resource
extension ResourceRequest {
  func save(_ resourceToSave: ResourceType, tokenNeeded: Bool, _ completion: @escaping (RequestOneResult<ResourceType>) -> Void) {
    do {
      var urlRequest = URLRequest(url: resourceURL)
      urlRequest.httpMethod = "POST"
      urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
      if tokenNeeded {
        guard let token = UserDefaultsService.shared.token else { return }
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      }
      urlRequest.httpBody = try JSONEncoder().encode(resourceToSave)
      let dataTask = resourceSession.dataTask(with: urlRequest) { (data, response, _) in
        guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
            return completion(.failure)
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

//MARK: - Link to a pivot in the database with a many-to-may relationship
extension ResourceRequest {
  func linkToPivot(tokenNeeded: Bool, _ completion: @escaping (RequestResult) -> Void) {
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "POST"
    if tokenNeeded {
      guard let token = UserDefaultsService.shared.token else { return }
      urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    let dataTask = resourceSession.dataTask(with: urlRequest) { data , response, _ in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 201  else {
          return completion(.failure)
      }
      completion(.success)
    }
    dataTask.resume()
  }
}

//MARK: - Update one resource
extension ResourceRequest {
  func update(_ updatedData: ResourceType, tokenNeeded: Bool, _ completion: @escaping (RequestOneResult<ResourceType>) -> Void) {
    do {
      var urlRequest = URLRequest(url: resourceURL)
      urlRequest.httpMethod = "PUT"
      urlRequest.httpBody = try JSONEncoder().encode(updatedData)
      urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
      if tokenNeeded {
        guard let token = UserDefaultsService.shared.token else { return }
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      }
      let dataTask = resourceSession.dataTask(with: urlRequest) { data, response, _ in
        guard let httpResponse = response as? HTTPURLResponse else {
          return completion(.failure)
        }
        guard httpResponse.statusCode == 200, let jsonData = data else {
          return completion(.failure)
        }
        do {
          let resources = try JSONDecoder().decode(ResourceType.self, from: jsonData)
          completion(.success(resources))
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

//MARK: - Delete one resource in cascade
extension ResourceRequest {
  func delete(tokenNeeded: Bool, _ completion: @escaping (RequestResult) -> Void) {
    var urlRequest = URLRequest(url: resourceURL)
    urlRequest.httpMethod = "DELETE"
    if tokenNeeded {
      guard let token = UserDefaultsService.shared.token else { return }
      urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    let dataTask = resourceSession.dataTask(with: urlRequest) { data , response, _ in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 204  else {
          return completion(.failure)
      }
      completion(.success)
    }
    dataTask.resume()
  }
}
