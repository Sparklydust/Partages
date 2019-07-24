//
//  AlertTitle.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - UIAlert title
enum AlertTitle: String {
  case addToCalendar = "Ajouté au calendrier"
  case reset = "Réinitialiser"
  case locationOff = "Localisation désactivée"
  case error = "Erreur"
  case success = "Succès"
  case cameraUse = "Accès à votre caméra et album"
  case restricted = "Accès restreint"
  case contactUs = "email de contact"
  case contactUsCanceled = "Envoi annulé"
  case contactUsFailed = "Erreur de Mail app"
  case contactUsSaved = "Email sauvegardé"
  case contactUsSent = "Merci de votre envoi"
  case emptyCase = "Élément manquant"
  case thankYou = "Merci"
  case sorry = "Désolé"
  case firstNameError = "Prénom invalide"
  case emailError = "Email invalide"
  case passwordError = "Mot de passe invalide"
  case loginError = "Erreur d'authentification"
  case userDeleted = "Effacer compte"
  case donatedItemUnselectable = "Don inaccessible"
  case donatedItemSelected = "Don à votre disposition"
  case confirmSelection = "Confirmer sélection"
}
