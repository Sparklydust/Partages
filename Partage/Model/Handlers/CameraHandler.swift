//
//  CameraHandler.swift
//  Partage
//
//  Created by Roland Lariotte on 30/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import Photos

class CameraHandler: NSObject {
  static let shared = CameraHandler()
  
  fileprivate var currentVC: UIViewController!
  
  var imagePickedBlock: ((UIImage) -> Void)?
}

//MARK: - Method to open camera
extension CameraHandler {
  func openCamera() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.allowsEditing = true
      myPickerController.sourceType = .camera
      currentVC.present(myPickerController, animated: true, completion: nil)
    }
  }
}

//MARK: - Method to open photo library
extension CameraHandler {
  func openPhotoLibrary() {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.allowsEditing = true
      myPickerController.sourceType = .photoLibrary
      currentVC.present(myPickerController, animated: true, completion: nil)
    }
  }
}

//MARK: - Alert action sheet that present choices between camera and photo library
extension CameraHandler {
  func showCameraActionSheet(vc: UIViewController) {
    currentVC = vc
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.camera.rawValue, style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.openCamera()
    }))
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.photoLibrary.rawValue, style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.openPhotoLibrary()
    }))
    actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.cancel.rawValue, style: .cancel, handler: nil))
    vc.present(actionSheet, animated: true, completion: nil)
  }
}

//MARK: - Check for user access authorizations before opening camera or photo library
extension CameraHandler {
  func goesToUserLibraryOrCamera(vc: UIViewController){
    currentVC = vc
    
    let libraryStatus = PHPhotoLibrary.authorizationStatus()
    let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)

    switch libraryStatus {
    case .denied, .notDetermined, .restricted:
      PHPhotoLibrary.requestAuthorization {
        (access) in
        guard access == .authorized else {
          DispatchQueue.main.async {
            vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
          }
          return
        }
        switch cameraStatus {
        case .denied, .notDetermined, .restricted:
          AVCaptureDevice.requestAccess(for: .video, completionHandler: {
            (access) in
            guard access else {
              vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
              return
            }
            self.showCameraActionSheet(vc: vc)
          })
        case .authorized:
          guard libraryStatus == .authorized else {
            vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
            return
          }
          self.showCameraActionSheet(vc: vc)
        @unknown default:
          fatalError()
        }
      }
    case .authorized:
      guard cameraStatus == .authorized else {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {
          (access) in
          guard access else {
            vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
            return
          }
          self.showCameraActionSheet(vc: vc)
        })
        return
      }
      self.showCameraActionSheet(vc: vc)
    @unknown default:
      fatalError()
    }
  }
}

//MARK: - Actions for when an image comes back
extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    currentVC.dismiss(animated: true, completion: nil)
  }
  
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      self.imagePickedBlock?(image)
    }
    else {
      currentVC.showAlert(title: .error, message: .noPictureloaded)
    }
    currentVC.dismiss(animated: true, completion: nil)
  }
}
