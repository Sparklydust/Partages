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
}
