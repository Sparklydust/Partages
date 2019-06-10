//
//  CameraHandler.swift
//  Partage
//
//  Created by Roland Lariotte on 30/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class CameraHandler: NSObject {
  static let shared = CameraHandler()
  
  fileprivate var currentVC: UIViewController!
  
  //MARK: Internal Properties
  var imagePickedBlock: ((UIImage) -> Void)?
  
  func camera() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.allowsEditing = true
      myPickerController.sourceType = .camera
      currentVC.present(myPickerController, animated: true, completion: nil)
    }
  }
  
  func photoLibrary() {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.allowsEditing = true
      myPickerController.sourceType = .photoLibrary
      currentVC.present(myPickerController, animated: true, completion: nil)
    }
  }
  
  func showActionSheet(vc: UIViewController) {
    currentVC = vc
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.camera.rawValue, style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.camera()
    }))
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.photoLibrary.rawValue, style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.photoLibrary()
    }))
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.cancel.rawValue, style: .cancel, handler: nil))
    vc.present(actionSheet, animated: true, completion: nil)
  }
}

//MARK: - Actions when the image comes back
extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    currentVC.dismiss(animated: true, completion: nil)
  }
  
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      self.imagePickedBlock?(image)
    }
    else {
      print("Something went wrong when loading an image into the profile picture")
    }
    currentVC.dismiss(animated: true, completion: nil)
  }
}
