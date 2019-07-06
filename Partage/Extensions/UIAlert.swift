//
//  UIAlert.swift
//  Partage
//
//  Created by Roland Lariotte on 30/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

typealias BoolCompletion = (_ result: Bool) -> Void

//MARK: - Alert with two actions and a completion handler
extension UIViewController {
  func showAlert(title: AlertTitle, message: AlertMessage, buttonName: ButtonName, completion: @escaping BoolCompletion) {
    let alert = UIAlertController(
      title: title.rawValue,
      message: message.rawValue,
      preferredStyle: .alert)
    alert.addAction(UIAlertAction(
      title: buttonName.rawValue,
      style: .default, handler: { (action) in
        completion(true)
    }))
    alert.addAction(UIAlertAction(
      title: ButtonName.cancel.rawValue,
      style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

//MARK: - Alert with one action
extension UIViewController {
  func showAlert(title: AlertTitle, message: AlertMessage) {
    let alert = UIAlertController(
      title: title.rawValue,
      message: message.rawValue,
      preferredStyle: .alert)
    alert.addAction(UIAlertAction(
      title: ButtonName.ok.rawValue, style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

//MARK: - Alert with one action and a completion handler
extension UIViewController {
  func showAlert(title: AlertTitle, message: AlertMessage, completion: @escaping BoolCompletion) {
    let alert = UIAlertController(
      title: title.rawValue,
      message: message.rawValue,
      preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: ButtonName.ok.rawValue, style: .cancel, handler: { (action) in
      completion(true)
    }))
    present(alert, animated: true, completion: nil)
  }
}

//MARK: - Alert that creates a path to the user settings
extension UIViewController {
  func goToUserSettings(title: AlertTitle, message: AlertMessage, buttonName: ButtonName) {
    self.showAlert(title: title, message: message, buttonName: buttonName, completion: {
      (true) in
      DispatchQueue.main.async {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
      }
    })
  }
}

//MARK: - Alert that shows an action sheet with cancel 
extension UIViewController {
  typealias AlertAction = () -> ()
  typealias AlertButtonAction = (ActionSheetLabel, AlertAction)
  
  func showActionSheetWithCancel(title: [AlertButtonAction]) {
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    for value in title {
      actionSheet.addAction(UIAlertAction(title: value.0.rawValue, style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
        value.1()
    }))
    }
    // PopoverController is for iPad
    if let popoverController = actionSheet.popoverPresentationController {
      popoverController.sourceView = view
      popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: .zero, height: .zero)
      popoverController.permittedArrowDirections = []
    }
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.cancel.rawValue, style: .cancel, handler: nil))
    self.present(actionSheet, animated: true, completion: nil)
  }
}
