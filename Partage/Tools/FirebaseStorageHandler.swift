//
//  FirebaseStorageHandler.swift
//  Partage
//
//  Created by Roland Lariotte on 19/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import Firebase

class FirebaseStorageHandler {
  static let shared = FirebaseStorageHandler()
}

//MARK: - Upload the profile picture to Firebase storage
extension FirebaseStorageHandler {
  func upload(_ profilePicture: UIImage, of user: FullUser) {
    guard UserDefaultsService.shared.userID != nil else { return }
    let profilePicturePath = "profilePicture/\(UserDefaultsService.shared.userID!).jpg"
    let profilePictureRef = Storage.storage().reference(withPath: profilePicturePath)
    
    guard let imageData = profilePicture.jpegData(compressionQuality: 1) else { return }
    let uploadMetadata = StorageMetadata.init()
    uploadMetadata.contentType = "image/jpeg"
    
    profilePictureRef.putData(imageData, metadata: uploadMetadata, completion: { (downloadedMetadata, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      profilePictureRef.downloadURL(completion: { (url, error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }
//        //MARK: - User this url.absoluteString to save path in Vapor User profile picture
//        if let url = url {
//          print("Here is your download URL: \(url.absoluteString)")
//
//        }
      })
    })
  }
}

//MARK: - Download saved profile picture from Firebase storage
extension FirebaseStorageHandler {
  func downloadProfilePicture(into uiImageView: UIImageView) {
    guard UserDefaultsService.shared.userID != nil else { return }
    let profilePicturePath = "profilePicture/\(UserDefaultsService.shared.userID!).jpg"
    let storageRef = Storage.storage().reference(withPath: profilePicturePath)
    
    storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      if let data = data {
        uiImageView.image = UIImage(data: data)
      }
    }
  }
}

//MARK: - Download saved profile picture of user from Firebase storage
extension FirebaseStorageHandler {
  func downloadProfilePicture(of user: String, into uiImageView: UIImageView) {
    guard UserDefaultsService.shared.userID != nil else { return }
    let profilePicturePath = "profilePicture/\(user).jpg"
    let storageRef = Storage.storage().reference(withPath: profilePicturePath)
    
    storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      if let data = data {
        uiImageView.image = UIImage(data: data)
      }
    }
  }
}

//MARK: - Download saved profile picture to message cell image from Firebase storage
extension FirebaseStorageHandler {
  func downloadProfilePicture(of user: String, into cell: MessageTVC) {
    guard UserDefaultsService.shared.userID != nil else { return }
    let profilePicturePath = "profilePicture/\(user).jpg"
    let storageRef = Storage.storage().reference(withPath: profilePicturePath)
    
    storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      if let data = data {
        cell.profileImage.image = UIImage(data: data)
      }
    }
  }
}

//MARK: - Download saved profile picture to message chat bubble image from Firebase storage
extension FirebaseStorageHandler {
  func downloadProfilePicture(of user: String, in cell: ConversationTVC) {
    guard UserDefaultsService.shared.userID != nil else { return }
    let profilePicturePath = "profilePicture/\(user).jpg"
    let storageRef = Storage.storage().reference(withPath: profilePicturePath)
    
    storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      if let data = data {
        cell.profileImage.image = UIImage(data: data)
      }
    }
  }
}

//MARK: - Delete profile picture off Firebase storage
extension FirebaseStorageHandler {
  func deleteProfilePicture() {
    guard UserDefaultsService.shared.userID != nil else { return }
    let profilePicturePath = "profilePicture/\(UserDefaultsService.shared.userID!).jpg"
    let storageRef = Storage.storage().reference(withPath: profilePicturePath)
    
    storageRef.delete { error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
    }
  }
}
