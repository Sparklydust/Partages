//
//  NotificationHandler.swift
//  Partage
//
//  Created by Roland Lariotte on 22/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import UserNotifications

final class NotificationHandler: NSObject {}

//MARK: - Enable foreground push notification
extension NotificationHandler: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound, .badge])
  }
}

//MARK: - To perform an action when clicked on a push notification
extension NotificationHandler {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    defer { completionHandler() }
    guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else { return }
    
    open(on: response, when: .newMessage, vc: .Message, identifier: .message)
    open(on: response, when: .itemPicked, vc: .HistoryFavorite, identifier: .historyFavorite)
  }
}

//MARK: - Open any view controller when user tap on push notification
extension NotificationHandler {
  func open(on response: UNNotificationResponse, when payloadNotification: PushNotification,
            vc viewController: ViewController, identifier: VCIdentifier) {
    let payload = response.notification.request.content
    guard let _ = payload.userInfo[payloadNotification.rawValue] else { return }
    
    let storyboard = UIStoryboard(name: viewController.rawValue, bundle: nil)
    let vc = storyboard.instantiateViewController(
      withIdentifier: identifier.rawValue)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window!.rootViewController!.present(vc, animated: false)
  }
}
