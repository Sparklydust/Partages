//
//  Auth.swift
//  Partage
//
//  Created by Roland Lariotte on 18/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - To handle user authentification
class Auth {
  private var authSession = URLSession(configuration: .default)

  init() {}

  //Initializer for testing purposes
  init(authSession: URLSession) {
    self.authSession = authSession
  }
}

//MARK: - Login method
extension Auth {
  func login(email: String, password: String, completion: @escaping (RequestResult) -> Void) {
    let path = NetworkPath.mainPath.description + NetworkPath.users.description + NetworkPath.login.description
    guard let url = URL(string: path) else { fatalError() }
    guard let loginString = "\(email):\(password)".data(using: .utf8)?.base64EncodedString() else { fatalError() }
    var loginRequest = URLRequest(url: url)
    loginRequest.addValue("Basic \(loginString)", forHTTPHeaderField: "Authorization")
    loginRequest.httpMethod = "POST"
    let dataTask = authSession.dataTask(with: loginRequest) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
        let jsonData = data else {
          completion(.failure)
          return
      }
      do {
        let token = try JSONDecoder().decode(Token.self, from: jsonData)
        UserDefaultsService.shared.userToken = token.token
        UserDefaultsService.shared.userID = token.userID.uuidString
        completion(.success)
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}
