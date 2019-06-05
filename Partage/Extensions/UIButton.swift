//
//  UIButton.swift
//  Partage
//
//  Created by Roland Lariotte on 05/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

enum ButtonName: String {
  case shareMain = "Je partage"
  case receiveMain = "Je reçois"
  case cancel = "Annuler"
  case save = "Enregistrer"
  case signUp = "S'inscrire"
  case signIn = "Se Connecter"
  case lowSignUp = "s'inscrire"
  case lowSignIn = "se connecter"
  case lowSignOut = "se déconnecter"
  case lowEraseAccount = "effacer mon compte"
  case lowLostPassword = "mot de passe perdu"
  case send = "Envoyer"
  case message = "Message"
  case receive = "Recevoir"
  case messageToReceiver = "Message au Receveur"
  case messageToDonator = "Message au Donateur"
  case modify = "Modifier"
  case addToCalendar = "Ajouter au calendrier"
  case history = "Historique"
  case saved = "Sauvegardé"
  case signInSignUp = "se connecter / s'inscrire"
  case afterSignedIn = "Bonjour"
  case donationMade = "Merci pour votre don"
}

//MARK: - Opening display share/receive button design
extension UIButton {
  func shareReceiveDesign(title: ButtonName, shadowHeight height: Int) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.iceBackground, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .mainAppFont, withSize: .shareButtonSize)
    self.backgroundColor = UIColor.mainBlue
    self.layer.cornerRadius = 20
    self.layer.shadowOffset = CGSize(width: 2, height: height)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 2
  }
}

//MARK: - Opening display sign in sign up button design
extension UIButton {
  func signInSignUpDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.typoBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .editLabelFont, withSize: .editLabelSize)
  }
}

//MARK: - Common button action design
extension UIButton {
  func commonDesign(title: ButtonName, shadowWidth width: Int, shadowHeight height: Int) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.lightBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .buttonFont, withSize: .mainSize)
    self.backgroundColor = UIColor.mainBlue
    self.layer.cornerRadius = 20
    self.layer.shadowOffset = CGSize(width: width, height: height)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 2
  }
}

//MARK: - Sign in Sign up -> selected and unselected design
extension UIButton {
  func signInSignUpSelectedDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.mainBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .editLabelFont, withSize: .signInSignUp)
  }
  
  func signInSignUpUnselectedDesign(title: ButtonName) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(UIColor.typoBlue, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .editLabelFont, withSize: .signInSignUp)
  }
}

//MARK: - Little button design
extension UIButton {
  func littleDesign(title: ButtonName, color: UIColor) {
    self.setTitle(title.rawValue, for: .normal)
    self.setTitleColor(color, for: .normal)
    self.titleLabel?.font = UIFont(customFont: .disconnectLabelFont, withSize: .disconnectLabelSize)
  }
}
