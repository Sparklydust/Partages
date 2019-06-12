//
//  UIAlert.swift
//  Partage
//
//  Created by Roland Lariotte on 30/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Alert with completion handler
extension UIViewController {
  func showAlert(title: AlertTitle,
                  message: AlertMessage,
                  buttonName: ButtonName,
                  completion: @escaping (_ result: Bool) -> Void) {
    let deleteAlert = UIAlertController(
      title: title.rawValue,
      message: message.rawValue,
      preferredStyle: .alert)
    deleteAlert.addAction(UIAlertAction(
      title: buttonName.rawValue,
      style: .default, handler: { (action) in
        completion(true)
    }))
    deleteAlert.addAction(UIAlertAction(
      title: ButtonName.cancel.rawValue,
      style: .cancel, handler: nil))
    present(deleteAlert, animated: true, completion: nil)
  }
}

//MARK: - Alert with one action
extension UIViewController {
  func showAlert(title: AlertTitle, message: AlertMessage) {
    let noEntryAlert = UIAlertController(
      title: title.rawValue,
      message: message.rawValue,
      preferredStyle: .alert)
    noEntryAlert.addAction(UIAlertAction(
      title: ButtonName.ok.rawValue, style: .cancel, handler: nil))
    present(noEntryAlert, animated: true, completion: nil)
  }
}

//MARK: - Alert that create a path to the user settings
extension UIViewController {
  func goToUserSettings(vc: UIViewController, title: AlertTitle, message: AlertMessage, buttonName: ButtonName) {
    vc.showAlert(title: title, message: message, buttonName: buttonName, completion: {
      (true) in
      DispatchQueue.main.async {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
      }
    })
  }
}
