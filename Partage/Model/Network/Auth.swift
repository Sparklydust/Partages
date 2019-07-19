//
//  Auth.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

enum AuthResult {
  case success
  case failure
}

//MARK: - To handle user authentification
class Auth {
  func logout() {
    UserDefaultsService.token = nil
  }
  
  func login(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
    let path = NetworkPath.login.rawValue
    guard let url = URL(string: path) else {
      fatalError()
    }
    guard let loginString = "\(email):\(password)".data(using: .utf8)?.base64EncodedString() else {
      fatalError()
    }
    var loginRequest = URLRequest(url: url)
    loginRequest.addValue("Basic \(loginString)", forHTTPHeaderField: "Authorization")
    loginRequest.httpMethod = "POST"
    
    let dataTask = URLSession.shared.dataTask(with: loginRequest) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
        let jsonData = data else {
          completion(.failure)
          return
      }
      do {
        let token = try JSONDecoder().decode(Token.self, from: jsonData)
        UserDefaultsService.token = token.token
        UserDefaultsService.userID = token.userID.uuidString
        completion(.success)
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}
