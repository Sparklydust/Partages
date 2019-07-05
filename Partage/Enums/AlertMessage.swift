//
//  AlertMessage.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - Alert message to be displayed after an UIAlert
enum AlertMessage: String {
  case needAccessToCalendar = "L'accès au calendrier n'a pas été autorisé. Vous pouvez changer vos réglages dans les paramètres et accéder à cette fonctionnalité."
  case addedToCalendar = "L'évènement a été ajouté avec succès à votre calendrier"
  case resetImage = "Voulez-vous supprimer ses images?"
  case locationOff = "L'accès à la localisation n'a pas été autorisé. Vous pouvez changer vos réglages dans les paramètres et accéder à cette fonctionnalité"
  case noPictureloaded = "Partage n'a pas pu télécharger votre image. Merci de vérifier vos paramètres"
  case cameraUse = "L'accès à votre caméra et album n' est pas autorisé. Vous pouvez changer vos réglages dans les paramètres et accéder à cette fonctionnalité"
  case locationIssue = "Il y a un problème de connection à la localisation du lieu de rendez-vous. Merci de réessayer ultérieurement"
  case getDirectionIssue = "Il y a un problème pour obtenir la direction au lieu de rendez-vous. Merci de vérifier vos réglages dans les paramètres ou de réessayer ultérieurement"
  case noDirectionsCalculated = "Nous n'avons pu calculer le temps de trajet. Veuillez vérifier votre connection"
  case restricted = "L'accès à ce service ne vous est pas autorisé. Pour changer vos réglages, veuillez-vous rapprocher de la personne succeptible de lever la restriction"
  case contactUs = "partage@contact.com"
  case contactUsCanceled = "N'hésitez pas à nous contacter ultérieurement, nous serrons à votre écoute."
  case contactUsFailed = "Contactez-nous à: \n\npartage@contact.com"
  case contactUsSaved = "N'hésitez pas à nous contacter, nous serrons à votre écoute."
  case contactUsSent = "Nous vous répondrons dans les plus brefs délais."
  case noImageSelected = "Vous n'avez pas ajoutez d'images. Merci de procéder avant tout enregistrement."
  case noAnnotationPoint = "Merci de rester appuyer sur lieu de rendez-vous pour le définir avant de l'enregistrer."
  case noItemTypeSelected = "Merci de sélectionner un type de don."
  case noItemName = "Merci de choisir un nom à votre don."
  case noItemDate = "Merci de choisir une date et une heure pour la remide de votre don."
  case noMeetingPoint = "Merci de choisir un lieu de rendez-vous."
  case noDescription = "Merci de choisir une description de votre don."
  case noImage = "Merci de choisir au minimum une image de votre don."
  case confirmDonation = "Veuillez confirmer votre don."
  case noFirebaseData = "Il n'y a, à ce jour, aucune donation. N'hésitez pas à réessayer ultérieurement."
  case resetDonation = "Êtes-vous sûr de réinitialiser votre don?"
}
