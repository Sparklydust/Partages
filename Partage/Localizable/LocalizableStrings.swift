//
//  LocalizableStrings.swift
//  Partage
//
//  Created by Roland Lariotte on 21/08/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

struct LocalizableStrings {}

//MARK: - International Strings - Not Localizable -
extension LocalizableStrings {
  static let emptyString = NSLocalizedString(
    "", comment: "empty string description to be used all over the app")
  static let dateOccurence = NSLocalizedString(
    "\\.\\d+", comment: "date occurence to translate Date() to readable String date")
  static let stringTokenFormat = NSLocalizedString(
    "%02x", comment: "Used to switch a token to a string format")
}

//MARK: - Keys for User Defaults and picker text color - Not Localizable -
extension LocalizableStrings {
  static let pickerTextColor = NSLocalizedString(
    "textColor", comment: "key for the picker view text color")
  static let partageTokenKey = NSLocalizedString(
    "PARTAGE-API-KEY", comment: "key for User Defaults, to store user token key from PartageServerSide")
  static let partageUserID = NSLocalizedString(
    "partage-user-id", comment: "key for User Defaults, to store user id key from PartageServerSide")
}

//MARK: - Apple devices name - Not Localizable -
extension LocalizableStrings {
  static let iPadFithGeneration = NSLocalizedString(
    "iPad (5th generation)", comment: "iPad 5th generation Apple Swift name")
  static let iPadSixthGeneration = NSLocalizedString(
    "iPad (6th generation)", comment: "iPad 6th generation Apple Swift name")
  static let iPadAir = NSLocalizedString(
    "iPad Air", comment: "iPad air Apple Swift name")
  static let iPadAirThirdGeneration = NSLocalizedString(
    "iPad Air (3rd generation)", comment: "iPad 3rd generation Apple Swift name")
  static let iPadAirTwo = NSLocalizedString(
    "iPad Air 2", comment: "iPad air 2 Apple Swift name")
  static let iPadProNineSevenInch = NSLocalizedString(
    "iPad Pro (9.7-inch)", comment: "iPad pro 9.7 inch Apple Swift name")
  static let iPadProTenFiveInch = NSLocalizedString(
    "iPad Pro (10.5-inch)", comment: "iPad pro 10.5 inch Apple Swift name")
  static let iPadProElevenInch = NSLocalizedString(
    "iPad Pro (11-inch)", comment: "iPad pro 11 inch Apple Swift name")
  static let iPadProTwelveNineInch = NSLocalizedString(
    "iPad Pro (12.9-inch)", comment: "iPad pro 12.9 inch Apple Swift name")
  static let iPadProSecondGeneration = NSLocalizedString(
    "iPad Pro (12.9-inch) (2nd generation)", comment: "iPad pro 12.9 inch 2nd gen Apple Swift name")
  static let iPadProThirdGeneration = NSLocalizedString(
    "iPad Pro (12.9-inch) (3rd generation)", comment: "iPad pro 12.9 inch 3rd gen Apple Swift name")
  static let iPhoneFiveS = NSLocalizedString(
    "iPhone 5s", comment: "iPhone 5s Apple Swift name")
  static let iPhoneSE = NSLocalizedString(
    "iPhone SE", comment: "iPhone SE Apple Swift name")
}

//MARK: - API requests paths - Localizable Strings -
extension LocalizableStrings {
  static let mainPath = NSLocalizedString(
    "http://192.168.1.61:8080/api/", comment: "main path to API request")
  static let login = NSLocalizedString(
    "login", comment: "login path")
  static let users = NSLocalizedString(
    "users/", comment: "users path")
  static let user = NSLocalizedString(
    "user/", comment: "one user path")
  static let myAccount = NSLocalizedString(
    "users/myAccount/", comment: "get user full account path")
  static let editAccount = NSLocalizedString(
    "users/editAccount/", comment: "user edit his account path, password not included")
  static let editAccountAndPassord = NSLocalizedString(
    "users/editAccountAndPassord/", comment: "user edit his account and password path")
  static let deleteUser = NSLocalizedString(
    "users/delete/", comment: "user delete his account path")
  static let donatedItems = NSLocalizedString(
    "donatedItems/", comment: "donated items path")
  static let favoritedItemID = NSLocalizedString(
    "favoritedItemID/", comment: "favorited item ID path")
  static let favoritedByUser = NSLocalizedString(
    "favoritedByUser/", comment: "favorited by user path")
  static let itemsFavorited = NSLocalizedString(
    "itemsFavorited", comment: "items favorited path")
  static let isReceivedBy = NSLocalizedString(
    "isReceivedBy/", comment: "item received by an user path")
  static let isPickedUp = NSLocalizedString(
    "isPickedUp", comment: "find pizked up item path")
  static let messages = NSLocalizedString(
    "messages/", comment: "messages path")
  static let ofUser = NSLocalizedString(
    "ofUser/", comment: "belonging of user path")
  static let chatMessages = NSLocalizedString(
    "chatMessages/", comment: "find chat messages bubbles path")
  static let deviceToken = NSLocalizedString(
    "deviceToken/", comment: "path to post and delete device token for push notification")
}

//MARK: - All static label or placeholder name - Localizable Strings -
extension LocalizableStrings {
  static let firsName = NSLocalizedString(
    "firstName", comment: "first name label")
  static let lastName = NSLocalizedString(
    "lastName", comment: "last name label")
  static let email = NSLocalizedString(
    "email", comment: "email label")
  static let password = NSLocalizedString(
    "password", comment: "password label")
  static let newPassword = NSLocalizedString(
    "newPassword", comment: "new password label")
  static let confirmPassword = NSLocalizedString(
    "confirmPassword", comment: "confirm password label")
  static let enterYourDonationName = NSLocalizedString(
    "enterYourDonationName", comment: "donated item name to be entered label")
  static let enterItemDescription = NSLocalizedString(
    "enterItemDescription", comment: "donated item description to be entered label")
  static let imageLoaderGuide = NSLocalizedString(
    "imageLoaderGuide", comment: "image loader guide for user")
  static let meetingPoint = NSLocalizedString(
    "meetingPoint", comment: "map view annotation label")
  static let userPosition = NSLocalizedString(
    "userPosition", comment: "user position indication label")
  static let receiverCalendarTitle = NSLocalizedString(
    "receiverCalendarTitle", comment: "label to tell the donation name to be received in the calendar")
  static let donorCalendarTitle = NSLocalizedString(
    "donorCalendarTitle", comment: "label to tell the donation name to be given in the calendar")
  static let donationIsSelected = NSLocalizedString(
    "donationIsSelected", comment: "label to tell the donated item is selected")
  static let donationNotSelected = NSLocalizedString(
    "donationNotSelected", comment: "label to tell the donated item is not selected")
  static let userLeftTheConversation = NSLocalizedString(
    "userLeftTheConversation", comment: "to tell when an user left a conversation in message")
  static let closedConversation = NSLocalizedString(
    "closedConversation", comment: "to tell users that the conversation is closed in messages table view")
}

//MARK: - Buttons name - Localizable Strings -
extension LocalizableStrings {
  static let shareMain = NSLocalizedString(
    "shareMain", comment: "SharingVC main button name")
  static let receiveMain = NSLocalizedString(
    "receiveMain", comment: "SharingVC main button name")
  static let cancel = NSLocalizedString(
    "cancel", comment: "cancel button name")
  static let save = NSLocalizedString(
    "save", comment: "save button name")
  static let signUp = NSLocalizedString(
    "signUp", comment: "capitalized sign up button name")
  static let signIn = NSLocalizedString(
    "signIn", comment: "capitalized sign in button name")
  static let lowContactUs = NSLocalizedString(
    "lowContactUs", comment: "lowercase contact us button name")
  static let lowSignUp = NSLocalizedString(
    "lowSignUp", comment: "lowercase sign up button name")
  static let lowSignIn = NSLocalizedString(
    "lowSignIn", comment: "lowercase sign in button name")
  static let lowSignOut = NSLocalizedString(
    "lowSignOut", comment: "lowercase sign out button name")
  static let lowEraseAccount = NSLocalizedString(
    "lowEraseAccount", comment: "lowercase erase account button name")
  static let lowLostPassword = NSLocalizedString(
    "lowLostPassword", comment: "lowercase lost password button")
  static let send = NSLocalizedString(
    "send", comment: "send button name")
  static let receiveThisDonation = NSLocalizedString(
    "receiveThisDonation", comment: "receive a donation button name")
  static let messageToReceiver = NSLocalizedString(
    "messageToReceiver", comment: "message to receiver button name")
  static let messageToDonor = NSLocalizedString(
    "messageToDonor", comment: "message to donor button name")
  static let addToCalendar = NSLocalizedString(
    "addToCalendar", comment: "add to calendar button name")
  static let history = NSLocalizedString(
    "history", comment: "history button name")
  static let favorite = NSLocalizedString(
    "favorite", comment: "favorite button name")
  static let signInSignUp = NSLocalizedString(
    "signInSignUp", comment: "sign in and sign up button name in ReceiverVC")
  static let afterSignedIn = NSLocalizedString(
    "afterSignedIn", comment: "saying hello to user after signing in in ReceiverVC")
  static let donationMade = NSLocalizedString(
    "donationMade", comment: "saying thanks to user after he has made a donation")
  static let edit = NSLocalizedString(
    "edit", comment: "edit button name")
  static let done = NSLocalizedString(
    "done", comment: "done button name related to the edit one")
  static let ok = NSLocalizedString(
    "ok", comment: "ok button name")
  static let settings = NSLocalizedString(
    "settings", comment: "settings button name")
  static let reset = NSLocalizedString(
    "reset", comment: "reset button name")
  static let makeADonation = NSLocalizedString(
    "makeADonation", comment: "make a donation button name")
  static let saveMeetingPoint = NSLocalizedString(
    "saveMeetingPoint", comment: "save a meeting point button name")
  static let setupMeetingPoint = NSLocalizedString(
    "setupMeetingPoint", comment: "setup, add a meeting point button name")
  static let changeMeetingPoint = NSLocalizedString(
    "changeMeetingPoint", comment: "change meeting point button name")
  static let confirm = NSLocalizedString(
    "confirm", comment: "confirm action button name")
  static let openMapApp = NSLocalizedString(
    "openMapApp", comment: "open in maps action button name")
  static let modifyDonation = NSLocalizedString(
    "modifyDonation", comment: "modify a donation button name")
}

//MARK: - Static item detail name - Localizable Strings -
extension LocalizableStrings {
  static let giveDonation = NSLocalizedString(
    "giveDonation", comment: "receiver sees when and who will give the donation label")
  static let receiveDonation = NSLocalizedString(
    "receiveDonation", comment: "donor sees when and who will receive the donation label")
  static let the = NSLocalizedString(
    "the", comment: "the as a label")
  static let at = NSLocalizedString(
    "at", comment: "at as a label")
  static let address = NSLocalizedString(
    "address", comment: "localisation label to show meeting point on map view")
  static let type = NSLocalizedString(
    "type", comment: "label telling the type of the donation")
  static let distanceInKm = NSLocalizedString(
    "distanceInKm", comment: "label telling the distance in kilometers")
  static let distanceInM = NSLocalizedString(
    "distanceInM", comment: "label telling the distance in meters")
}

//MARK: - UIAlert action sheet title - Localizable Strings -
extension LocalizableStrings {
  static let camera = NSLocalizedString(
    "camera", comment: "to show camera option on action sheet label")
  static let photoLibrary = NSLocalizedString(
    "photoLibrary", comment: "to show photo library on action sheet label")
}

//MARK: - UIAlert title - Localizable Strings -
extension LocalizableStrings {
  static let locationOffTitle = NSLocalizedString(
    "locationOffTitle", comment: "location off alert title")
  static let errorTitle = NSLocalizedString(
    "errorTitle", comment: "classic error alert title")
  static let successTitle = NSLocalizedString(
    "successTitle", comment: "classic success title")
  static let cameraUseTitle = NSLocalizedString(
    "cameraUseTitle", comment: "access to camera asked to user title")
  static let restrictedTitle = NSLocalizedString(
    "restrictedTitle", comment: "access restricted title")
  static let contactUsTitle = NSLocalizedString(
    "contactUsTitle", comment: "email to contact us title")
  static let contactUsCanceledTitle = NSLocalizedString(
    "contactUsCanceledTitle", comment: "user canceled to send a message from Mail app alert title")
  static let contactUsFailedTitle = NSLocalizedString(
    "contactUsFailedTitle", comment: "Mail app encounter an error alert title")
  static let contactUsSavedTitle = NSLocalizedString(
    "contactUsSavedTitle", comment: "user saved an email to send us alert title")
  static let contactUsSentTitle = NSLocalizedString(
    "contactUsSentTitle", comment: "user sent us an email alert title")
  static let emptyCaseTitle = NSLocalizedString(
    "emptyCaseTitle", comment: "missing element alert title")
  static let thankYouTitle = NSLocalizedString(
    "thankYouTitle", comment: "saying thank you to an user alert title")
  static let firstNameErrorTitle = NSLocalizedString(
    "firstNameErrorTitle", comment: "invalid first name alert title")
  static let emailErrorTitle = NSLocalizedString(
    "emailErrorTitle", comment: "invalid email alert title")
  static let passwordErrorTitle = NSLocalizedString(
    "passwordErrorTitle", comment: "invalid password alert title")
  static let loginErrorTitle = NSLocalizedString(
    "loginErrorTitle", comment: "login error alert title")
  static let userDeletedTitle = NSLocalizedString(
    "userDeletedTitle", comment: "alert title to ask the user if he really wants to delete his account")
  static let itemUnselectableTitle = NSLocalizedString(
    "itemUnselectableTitle", comment: "telling the user that a donation can not be accessed title")
  static let itemSelectedTitle = NSLocalizedString(
    "itemSelectedTitle", comment: "telling the user that an donation is now his")
}

//MARK: - Donator item type to be chosen on DonationItem - Localizable Strings -
extension LocalizableStrings {
  static let selectItem = NSLocalizedString(
    "selectItem", comment: "showing type to select on picker view")
  static let food = NSLocalizedString(
    "food", comment: "food type for user to choose on picker view")
  static let clothes = NSLocalizedString(
    "clothes", comment: "clothes type for user to choose on picker view")
  static let hygiene = NSLocalizedString(
    "hygiene", comment: "hygiene type for user to choose on picker view")
  static let other = NSLocalizedString(
    "other", comment: "other type for user to choose on picker view")
}

//MARK: - Contact us email sender from Mail app attributes - Localizable Strings -
extension LocalizableStrings {
  static let partageEmail = NSLocalizedString(
    "partageEmail", comment: "Partage email: partage@contact.com")
  static let subject = NSLocalizedString(
    "subject", comment: "email subject")
  static let messageBody = NSLocalizedString(
    "messageBody", comment: "email welcome sentence")
}

//MARK: - Alert message to be displayed on an UIAlert - Localizable Strings -
extension LocalizableStrings {
  static let needAccessToCalendar = NSLocalizedString(
    "needAccessToCalendar", comment: "telling the user that Calendar app access is disabled")
  static let addedToCalendar = NSLocalizedString(
    "addedToCalendar", comment: "telling the user that the event was added to his Calendar app")
  static let resetImage = NSLocalizedString(
    "resetImage", comment: "alert that asked if user wants to delete his image")
  static let locationOff = NSLocalizedString(
    "locationOff", comment: "telling the user that location access is disabled")
  static let noPictureloaded = NSLocalizedString(
    "noPictureloaded", comment: "telling the user that there was trouble loading the image")
  static let cameraUse = NSLocalizedString(
    "cameraUse", comment: "telling the user that access to camera and album is disable")
  static let locationIssue = NSLocalizedString(
    "locationIssue", comment: "telling the user about a network issue when locating the meeting point")
  static let getDirectionIssue = NSLocalizedString(
    "getDirectionIssue", comment: "telling the user about an issue to determine the direction on map")
  static let noDirectionsCalculated = NSLocalizedString(
    "noDirectionsCalculated", comment: "alert when calculated trip time failed")
  static let restricted = NSLocalizedString(
    "restricted", comment: "telling the user about restricted access. Mainly for parental control.")
  static let contactUs = NSLocalizedString(
    "contactUs", comment: "Partage email address: partage@contact.com")
  static let contactUsCanceled = NSLocalizedString(
    "contactUsCanceled", comment: "email canceled by user alert")
  static let contactUsFailed = NSLocalizedString(
    "contactUsFailed", comment: "email failed, then give Partage email address to user")
  static let contactUsSaved = NSLocalizedString(
    "contactUsSaved", comment: "telling the user to not hesitate to contact us if email saved in Mail app")
  static let contactUsSent = NSLocalizedString(
    "contactUsSent", comment: "telling the user that Partage will contact them shortly")
  static let noImageSelected = NSLocalizedString(
    "noImageSelected", comment: "no image has been added alert")
  static let noItemTypeSelected = NSLocalizedString(
    "noItemTypeSelected", comment: "telling the user to select a type to his donation")
  static let noItemName = NSLocalizedString(
    "noItemName", comment: "telling the user to give a name to his donation")
  static let noItemDate = NSLocalizedString(
    "noItemDate", comment: "telling the user to choose a date and time to his donation")
  static let noMeetingPoint = NSLocalizedString(
    "noMeetingPoint", comment: "telling the user to add a meeting point to his donation")
  static let noDescription = NSLocalizedString(
    "noDescription", comment: "telling the user to give a description to his donation")
  static let noImage = NSLocalizedString(
    "noImage", comment: "telling the user to click on the blue cross to select an image to his donation")
  static let confirmDonation = NSLocalizedString(
    "confirmDonation", comment: "ask the user to confirm his donation")
  static let resetDonation = NSLocalizedString(
    "resetDonation", comment: "ask the user if he really wants to reset his donation")
  static let emailAlreadyInUse = NSLocalizedString(
    "emailAlreadyInUse", comment: "telling the user that this email addess is already in use by another account")
  static let passwordDoesntMatch = NSLocalizedString(
    "passwordDoesntMatch", comment: "telling the user that password and confirm password don't match")
  static let addFirstName = NSLocalizedString(
    "addFirstName", comment: "telling the user to add a first name")
  static let addEmail = NSLocalizedString(
    "addEmail", comment: "telling the user to add an email address")
  static let passwordTooShort = NSLocalizedString(
    "passwordTooShort", comment: "telling the user that his password is too short")
  static let loginError = NSLocalizedString(
    "loginError", comment: "telling the user that his email or password are incorrect")
  static let notConnected = NSLocalizedString(
    "notConnected", comment: "asking the user to authenticate to access most of the app functions")
  static let signUpError = NSLocalizedString(
    "signUpError", comment: "telling the user that this email is already in our database")
  static let networkRequestError = NSLocalizedString(
    "networkRequestError", comment: "telling the user about a netword error when ResourceRequest method encounter a failure")
  static let userDeleted = NSLocalizedString(
    "userDeleted", comment: "ask the user confirmation before deleting his account from Partage database")
  static let itemAlreadySelected = NSLocalizedString(
    "itemAlreadySelected", comment: "telling the user receiver that this donation has already been selected")
  static let donatedItemSelected = NSLocalizedString(
    "donatedItemSelected", comment: "telling the user receiver info after he has selected a donation")
  static let confirmSelection = NSLocalizedString(
    "confirmSelection", comment: "asking the user receiver if he really wants this donation")
  static let confirmDonatedItemRemoved = NSLocalizedString(
    "confirmDonatedItemRemoved", comment: "telling the user receiver that he has unselected a donation")
  static let confirmChanges = NSLocalizedString(
    "confirmChanges", comment: "asking the user donor to confirm his modifications on his donation")
  static let donatedItemDeleted = NSLocalizedString(
    "donatedItemDeleted", comment: "telling the user donor that his donation has been deleting from Partage database")
  static let canNotSendMessage = NSLocalizedString(
    "canNotSendMessage", comment: "telling the user donor that he is trying to send a message to himself")
  static let canNotSelectOwnDonation = NSLocalizedString(
    "canNotSelectOwnDonation", comment: "telling the user donor that he is trying to select his own donation")
}
