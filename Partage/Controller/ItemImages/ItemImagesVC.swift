//
//  ItemImagesVC.swift
//  Partage
//
//  Created by Roland Lariotte on 11/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ItemImagesVC: UIViewController {
  
  @IBOutlet weak var userGuideLabel: UILabel!
  
  @IBOutlet weak var mainSquareView: UIView!
  
  @IBOutlet var stackViews: [UIStackView]!
  @IBOutlet var littleSquareViews: [UIView]!
  @IBOutlet var littleSquareImages: [UIImageView]!
  @IBOutlet var littleSquareButtons: [UIButton]!
  @IBOutlet var resetAndSaveButton: [UIButton]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
  }
}

//MARK: - Load top left image button action
extension ItemImagesVC {
  @IBAction func topLeftImageButtonAction(_ sender: Any) {
    loadImage(to: littleSquareImages[0])
  }
}

//MARK: - Load top right image button action
extension ItemImagesVC {
  @IBAction func topRightImageButtonAction(_ sender: Any) {
    loadImage(to: littleSquareImages[1])
  }
}

//MARK: - Load bottom left image button action
extension ItemImagesVC {
  @IBAction func bottomLeftImageButtonAction(_ sender: Any) {
    loadImage(to: littleSquareImages[2])
  }
}

//MARK: - Load bottom right image button action
extension ItemImagesVC {
  @IBAction func bottomRightImageButtonAction(_ sender: Any) {
    loadImage(to: littleSquareImages[3])
  }
}

//MARK: - Reset images Button action
extension ItemImagesVC {
  @IBAction func resetButtonAction(_ sender: Any) {
    deleteLittleSquareImages()
  }
}

//MARK: - Save images button action
extension ItemImagesVC {
  @IBAction func saveButtonAction(_ sender: Any) {
  }
}

//MARK: - Setup main developer design
extension ItemImagesVC {
  func setupMainDesign() {
    navigationItem.setupNavBarProfileImage()
    setupMainSquare()
    setupLittleSquareViews()
    setupLittleSquareImages()
    setupResetAndSaveButton()
    setupUserGuideLabel()
    setupOutletsCollectionsOrder()
  }
}

//MARK: - Setup for donator view design
extension ItemImagesVC {
  func setupDonatorVCLook() {
    
  }
}

//MARK: - Setup for receiver view design
extension ItemImagesVC {
  func setupReceiverVCLook() {
    
  }
}

//MARK: - Setup main square design
extension ItemImagesVC {
  func setupMainSquare() {
    mainSquareView.backgroundColor = UIColor.middleBlue
    mainSquareView.layer.cornerRadius = 5
  }
}

//MARK: - Setup all little square view design
extension ItemImagesVC {
  func setupLittleSquareViews() {
    for view in littleSquareViews {
      view.layer.cornerRadius = 5
    }
  }
}

//MARK: - Setup all little square images design
extension ItemImagesVC {
  func setupLittleSquareImages() {
    for image in littleSquareImages {
      image.layer.cornerRadius = 5
    }
  }
}

//MARK: - Setup reset and save button design
extension ItemImagesVC {
  func setupResetAndSaveButton() {
    resetAndSaveButton[0].commonDesign(title: .reset)
    resetAndSaveButton[1].commonDesign(title: .save)
  }
}

//MARK: - Setup user guide label design
extension ItemImagesVC {
  func setupUserGuideLabel() {
    userGuideLabel.setupFont(as: .superclarendonBold, sized: .sixteen, in: .middleBlue)
    userGuideLabel.text = StaticLabel.imageLoaderGuide.rawValue
    userGuideLabel.textAlignment = .center
  }
}

//MARK: - Setup one picture loaded receiver design
extension ItemImagesVC {
  func setupOnePictureLoaded() {
    stackViews[0].isHidden = false
    stackViews[1].isHidden = true
    littleSquareViews[0].isHidden = false
    littleSquareViews[1].isHidden = true
  }
}

//MARK: - Setup two pictures loaded receiver design
extension ItemImagesVC {
  func setupTwoPicturesLoaded() {
    showAllSatckViews()
    littleSquareViews[0].isHidden = false
    littleSquareViews[1].isHidden = true
    littleSquareViews[2].isHidden = false
    littleSquareViews[3].isHidden = true
  }
}

//MARK: - Setup three pictures loaded receiver design
extension ItemImagesVC {
  func setupThreePicturesLoaded() {
    showAllSatckViews()
    littleSquareViews[0].isHidden = false
    littleSquareViews[1].isHidden = true
    littleSquareViews[2].isHidden = false
    littleSquareViews[3].isHidden = false
  }
}

//MARK: - Setup four pictures loaded receiver design
extension ItemImagesVC {
  func setupfourPicturesLoaded() {
    showAllSatckViews()
    littleSquareViews[0].isHidden = false
    littleSquareViews[1].isHidden = false
    littleSquareViews[2].isHidden = false
    littleSquareViews[3].isHidden = false
  }
}

//MARK: - Setup outlet collection to be in order
extension ItemImagesVC {
  func setupOutletsCollectionsOrder() {
    stackViews = stackViews.sorted(by: { $0.tag < $1.tag })
    littleSquareViews = littleSquareViews.sorted(by: { $0.tag < $1.tag })
    littleSquareImages = littleSquareImages.sorted(by: { $0.tag < $1.tag })
    littleSquareButtons = littleSquareButtons.sorted(by: { $0.tag < $1.tag })
    resetAndSaveButton = resetAndSaveButton.sorted(by: { $0.tag < $1.tag })
  }
}

//MARK: - Show top and bottom stack views
extension ItemImagesVC {
  func showAllSatckViews() {
    for view in stackViews {
      view.isHidden = false
    }
  }
}

//MARK: - Method to load images from camera or photo library
extension ItemImagesVC {
  func loadImage(to imageView: UIImageView) {
    CameraHandler.shared.goesToUserLibraryOrCamera(vc: self)
    CameraHandler.shared.imagePickedBlock = {
      (image) in
      imageView.image = image
    }
  }
}

//MARK: - Delete little square images if not empty
extension ItemImagesVC {
  func deleteLittleSquareImages() {
    for square in littleSquareImages {
      if square.image != nil {
        showAlert(title: .resetImage, message: .resetImage, buttonName: .reset) {
          (true) in
          for square in self.littleSquareImages {
            square.image = nil
          }
        }
      }
    }
  }
}
