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

//MARK: - Methods to show action sheet with camera and/or photo library as option
extension CameraHandler {
  func showActionSheetWithCameraAndLibrary(vc: UIViewController) {
    vc.showActionSheetWithCancel(title: [
      (ActionSheetLabel.camera, { [weak self] in self?.openCamera() }),
      (ActionSheetLabel.photoLibrary, { [weak self] in self?.openPhotoLibrary() })
      ])
  }
}

//MARK: - Check for user access authorizations before opening camera or photo library
extension CameraHandler {
  func goesToUserLibraryOrCamera(vc: UIViewController){
    currentVC = vc
    
    let libraryStatus = PHPhotoLibrary.authorizationStatus()
    let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
    
    switch libraryStatus {
    case .denied, .notDetermined:
      PHPhotoLibrary.requestAuthorization {
        (access) in
        guard access == .authorized else {
          DispatchQueue.main.async {
            vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
          }
          return
        }
        switch cameraStatus {
        case .denied, .notDetermined:
          AVCaptureDevice.requestAccess(for: .video, completionHandler: {
            (access) in
            guard access else {
              DispatchQueue.main.async {
                vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
              }
              return
            }
            DispatchQueue.main.async {
              self.showActionSheetWithCameraAndLibrary(vc: vc)
            }
          })
        case .restricted:
          DispatchQueue.main.async {
            vc.showAlert(title: .restricted, message: .restricted)
          }
        case .authorized:
          guard libraryStatus == .authorized else {
            DispatchQueue.main.async {
              vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
            }
            return
          }
          DispatchQueue.main.async {
            self.showActionSheetWithCameraAndLibrary(vc: vc)
          }
        @unknown default:
          fatalError()
        }
      }
    case .restricted:
      DispatchQueue.main.async {
        vc.showAlert(title: .restricted, message: .restricted)
      }
    case .authorized:
      guard cameraStatus == .authorized else {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {
          (access) in
          guard access else {
            DispatchQueue.main.async {
              vc.goToUserSettings(title: .cameraUse, message: .cameraUse, buttonName: .settings)
            }
            return
          }
          DispatchQueue.main.async {
            self.showActionSheetWithCameraAndLibrary(vc: vc)
          }
        })
        return
      }
      DispatchQueue.main.async {
        self.showActionSheetWithCameraAndLibrary(vc: vc)
      }
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
