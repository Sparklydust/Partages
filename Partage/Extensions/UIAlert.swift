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
  func showActionSheetWithCancel(vc: UIViewController, title: [ActionSheetLabel] /*Make a function parameter here to match title*/) {
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    for value in title {
      actionSheet.addAction(UIAlertAction(title: value.rawValue, style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      
        //Use the parameter function here to match title
      
    }))
    }
    
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.cancel.rawValue, style: .cancel, handler: nil))
    vc.present(actionSheet, animated: true, completion: nil)
  }
}
