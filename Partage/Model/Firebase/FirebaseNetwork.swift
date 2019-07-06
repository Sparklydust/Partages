//
//  FirebaseNetwork.swift
//  Partage
//
//  Created by Roland Lariotte on 06/07/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

typealias VoidCompletion = () -> ()

class FirebaseNetwork {
  static let shared = FirebaseNetwork()
  
  var rootRef: DatabaseReference!
}

//MARK: - User register method
extension FirebaseNetwork {
  func userRegisterWith(_ firstName: String, _ email: String, _ password: String, vc: UIViewController, completion: @escaping VoidCompletion) {
    Auth.auth().createUser(withEmail: email, password: password) {
      (user, error) in
      guard error == nil else {
        vc.showAlert(title: .error, message: .emailAlreadyInUse)
        completion()
        return
      }
      completion()
      vc.showAlert(title: .success, message: .registrationSuccess, completion: {
        (true) in
        vc.performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: vc)
      })
    }
  }
}

//MARK: - User login method
extension FirebaseNetwork {
  func userLoginWith( _ email: String, _ password: String, vc: UIViewController, completion: @escaping VoidCompletion) {
    Auth.auth().signIn(withEmail: email, password: password) {
      (user, error) in
      guard error == nil else {
        vc.showAlert(title: .loginError, message: .loginError)
        completion()
        return
      }
      vc.performSegue(withIdentifier: Segue.unwindsToSharingVC.rawValue, sender: vc)
    }
  }
}

//MARK: - User sign out method
extension FirebaseNetwork {
  func userSignOut() {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print(signOutError.localizedDescription)
    }
  }
}

//MARK: - Lost password method
extension FirebaseNetwork {
  func userResetPasswordWith( _ email: String, vc: UIViewController, completion: @escaping VoidCompletion) {
    Auth.auth().sendPasswordReset(withEmail: email) {
      (error) in
      guard error == nil else {
        vc.showAlert(title: .error, message: .unknownEmail)
        completion()
        return
      }
      completion()
      vc.showAlert(title: .success, message: .resetPassword, completion: {
        (true) in
        vc.dismiss(animated: true, completion: nil)
      })
    }
  }
}
