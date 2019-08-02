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
  
  let baseURL = NetworkPath.mainPath.rawValue
  let resourceURL: URL
  
  init(resourcePath: String) {
    guard let resourceURL = URL(string: baseURL) else {
      fatalError()
    }
    self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
  }
}

//MARK: - Get one resource with no token needed
extension ResourceRequest {
  func get(completion: @escaping (RequestOneResult<ResourceType>) -> Void) {
    let urlRequest = URLRequest(url: resourceURL)
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
      guard let jsonData = data else {
        completion(.failure)
        return
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

//MARK: - Get array of resources with no token needed
extension ResourceRequest {
  func getAll(completion: @escaping (RequestArrayResult<ResourceType>) -> Void) {
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

//MARK: - Get array of resources with token needed
extension ResourceRequest {
  func getAllWithToken(completion: @escaping (RequestArrayResult<ResourceType>) -> Void) {
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

//MARK: - Save one resource with no token needed
extension ResourceRequest {
  func save(_ resourceToSave: ResourceType, completion: @escaping (RequestOneResult<ResourceType>) -> Void) {
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

//MARK: - Save one resource with token needed
extension ResourceRequest {
  func saveWithToken(_ resourceToSave: ResourceType, completion: @escaping (RequestOneResult<ResourceType>) -> Void) {
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

//MARK: - Link to pivot in database with many-to-may relationship
extension ResourceRequest {
  func linkToPivot(_ completion: @escaping (RequestResult) -> Void) {
    guard let token = UserDefaultsService.token else {
      Auth().logout()
      return
    }
    var urlRequest = URLRequest(url: resourceURL)
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

//MARK: - Update one resource with token needed
extension ResourceRequest {
  func update(with updateData: ResourceType, completion: @escaping (RequestOneResult<ResourceType>) -> Void) {
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

//MARK: - Delete one resource with token needed
extension ResourceRequest {
  func delete(_ completion: @escaping (RequestResult) -> Void) {
    guard let token = UserDefaultsService.token else { return }
    
    var urlRequest = URLRequest(url: resourceURL)
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
