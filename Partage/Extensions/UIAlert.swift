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
  func showAlert(title: String,
                  message: String,
                  completion: @escaping (_ result: Bool) -> Void) {
    let deleteAlert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    deleteAlert.addAction(UIAlertAction(
      title: "OK",
      style: .default, handler: { (action) in
        completion(true)
    }))
    deleteAlert.addAction(UIAlertAction(
      title: "Cancel",
      style: .cancel, handler: nil))
    present(deleteAlert, animated: true, completion: nil)
  }
}

//MARK: - Alert with one action
extension UIViewController {
  func showAlert(title: String, message: String) {
    let noEntryAlert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    noEntryAlert.addAction(UIAlertAction(
      title: "OK", style: .cancel, handler: nil))
    present(noEntryAlert, animated: true, completion: nil)
  }
}
