//
//  AppDelegate.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  let notificationHandler = NotificationHandler()
}

//MARK: - First setup of the Partage app
extension AppDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupTabBar()
    FirebaseApp.configure()
    setupGoogleAdMob()
    registerForPushNotifications(application: application)
    return true
  }
}

//MARK: - Setup TabBar design
extension AppDelegate {
  func setupTabBar() {
    UITabBar.appearance().barTintColor = .iceBackground
    UITabBar.appearance().tintColor = .mainBlue
    UITabBar.appearance().unselectedItemTintColor = .typoBlueLight
    UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
    UITabBar.appearance().clipsToBounds = true
  }
}

//MARK: - Setup Google AdMob
extension AppDelegate {
  func setupGoogleAdMob() {
    GADMobileAds.sharedInstance().requestConfiguration.tag(forChildDirectedTreatment: false)
    GADMobileAds.sharedInstance().start(completionHandler: nil)
  }
}

//MARK: - Setup push notification path and device token
extension AppDelegate {
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let pushNotificationPath =
      NetworkPath.mainPath.description + NetworkPath.deviceToken.description
    sendPushNotificationDetails(to: pushNotificationPath, using: deviceToken)
  }
}
