//
//  ApnsUploads.swift
//  Partage
//
//  Created by Roland Lariotte on 22/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import UserNotifications

//MARK: - Register for push notifications and delegate it to NotificationHandler
extension AppDelegate {
  func registerForPushNotifications(application: UIApplication) {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.badge, .sound, .alert]) {
      [weak self] granted, _ in
      guard granted else { return }
      
      center.delegate = self?.notificationHandler
      
      DispatchQueue.main.async {
        application.registerForRemoteNotifications()
      }
    }
  }
}

//MARK: - Push notification path to PartageServerSide using device device token
extension AppDelegate {
  func sendPushNotificationDetails(to urlString: String,
                                   using deviceToken: Data) {
    guard let url = URL(string: urlString) else { return }
    let token = deviceToken.reduce(StaticLabel.emptyString.description) {
      $0 + String(format: StaticLabel.stringTokenFormat.description, $1)
    }
    var obj: [String: Any] = [
      "token": token,
      "debug": false
    ]
    
    #if DEBUG
    obj["debug"] = true
    #endif
    
    var request = URLRequest(url: url)
    request.addValue("application/json",
                     forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = try! JSONSerialization.data(withJSONObject: obj)
    
    #if DEBUG
    print("Device Token: \(token)")
    
    let pretty = try! JSONSerialization.data(
      withJSONObject: obj, options: .prettyPrinted)
    print(String(data: pretty, encoding: .utf8)!)
    #endif
    
    URLSession.shared.dataTask(with: request).resume()
  }
}
