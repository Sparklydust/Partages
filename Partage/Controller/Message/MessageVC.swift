//
//  MessageVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class MessageVC: UIViewController {
  
  @IBOutlet weak var messageTableView: UITableView!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  let userID = UserDefaultsService.shared.userID
  
  var messages = [Message]()
  var chatMessages = [ChatMessage]()
  
  var firstUserID: String?
  var secondUserID: String?
  var messageIDToOpen: Int?
  var messageIndexPathToOpen: Int?
  
  let refreshControl = UIRefreshControl()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    checkIfAnUserIsConnected()
    getAllUserMessagesFromTheDatabase()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    triggerActivityIndicator(false)
  }
}

//MARK: - Unwind Segue retrieve data from ItemDetailsVC and ItemSelectedVC
extension MessageVC {
  @IBAction func unwindToMessageVC(segue: UIStoryboardSegue) {
    if segue.source is ItemDetailsVC {
      if let senderVC = segue.source as? ItemDetailsVC {
        senderVC.firstUserID = firstUserID ?? ""
        senderVC.secondUserID = secondUserID ?? ""
      }
    }
    else if segue.source is ItemSelectedVC {
      if let senderVC = segue.source as? ItemSelectedVC {
        senderVC.firstUserID = firstUserID ?? ""
        senderVC.secondUserID = secondUserID ?? ""
      }
    }
  }
}

//MARK: - Buttons actions
extension MessageVC {
  //MARK: Edit button action
  @IBAction func editButton(_ sender: UIBarButtonItem) {
    UIView.animate(withDuration: 0.3) {
      self.messageTableView.isEditing = !self.messageTableView.isEditing
      sender.title = (self.messageTableView.isEditing) ? ButtonName.done.rawValue : ButtonName.edit.rawValue
    }
  }
}

//MARK: - Swap to delete cell action
extension MessageVC {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = UIColor.iceBackground
  }
}

//MARK: - Main setup
extension MessageVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupCustomCell()
    setupEditButton()
    setupNavigationController()
    setupTableViewDesign()
    setupCellHeightForIPad()
    setupRefreshControl()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
  
  //MARK: All delegates
  func setupAllDelegates() {
    messageTableView.delegate = self
    messageTableView.dataSource = self
  }
}

//MARK: - Setup table view design
extension MessageVC {
  func setupTableViewDesign() {
    messageTableView.setupMainBackgroundColor()
  }
}

//MARK: - Setup Table view to display messages
extension MessageVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.messageCellIdentifier.rawValue, for: indexPath) as! MessageTVC
    
    var date: String
    var time: String
    var dateToShow: String
    
    let messageInfo = messages[indexPath.row]
    showBoldMessageIfIsNotRead(in: cell, search: messageInfo)
    
    let isoDateString = messageInfo.date
    let trimmedIsoString = isoDateString.replacingOccurrences(of: StaticLabel.dateOccurence.rawValue, with: StaticLabel.emptyString.rawValue, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    date = dateAndTime!.asString(style: .short)
    time = dateAndTime!.asString()
    if dateAndTime!.isGreaterThanDate(dateToCompare: Date()) {
      dateToShow = "\(date)"
    }
    else {
      dateToShow = "\(time)"
    }
    
    cell.dateLabel.text = dateToShow
    
    return cell
  }
}

//MARK: - Setup Edit button in navigation bar
extension MessageVC {
  func setupEditButton() {
    editButton.editButtonDesign()
  }
}

//MARK: - Setup all custom cells
extension MessageVC {
  func setupCustomCell() {
    messageTableView.setupCustomCell(nibName: .messageCellIdentifier, identifier: .messageCellIdentifier)
  }
}

//MARK: - Segue action
extension MessageVC {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let messageID = messages[indexPath.row].id else { return }
    messageIDToOpen = messageID
    fetchChatMessagesFromSelectedCells(messageID)
  }
}

//MARK: - Setup navigation controller design
extension MessageVC {
  func setupNavigationController() {
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.tintColor = .typoBlue
    navigationController?.navigationBar.barTintColor = .iceBackground
    navigationController?.navigationBar.isTranslucent = false
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup custom cell heigt for iPad
extension MessageVC {
  func setupCellHeightForIPad() {
    if UIDevice.current.userInterfaceIdiom == .pad {
      messageTableView.rowHeight = 120
    }
  }
}

//MARK: - Check if an user is connected, else send him to SignInVC
extension MessageVC {
  func checkIfAnUserIsConnected() {
    guard UserDefaultsService.shared.token != nil else {
      showAlert(title: .restricted, message: .notConnected) { (true) in
        self.performSegue(withIdentifier: Segue.goesToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
  }
}

//MARK: - Refresh control method to reload data
extension MessageVC {
  func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(refreshMessages), for: .valueChanged)
    refreshControl.commonDesign(title: .emptyString)
    messageTableView.addSubview(refreshControl)
  }
  
  @objc private func refreshMessages(_ sender: Any) {
    getAllUserMessagesFromTheDatabase()
    endRefreshing()
  }
  
  func endRefreshing() {
    refreshControl.endRefreshing()
  }
}

//MARK: - Activity Indicator action and setup
extension MessageVC {
  func triggerActivityIndicator(_ action: Bool) {
    guard action else {
      hideActivityIndicator()
      return
    }
    showActivityIndicator()
  }
  
  func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.style = .whiteLarge
    activityIndicator.color = .mainBlue
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
  }
  
  func hideActivityIndicator() {
    activityIndicator.isHidden = true
  }
}

//MARK: - Found index path of message to be opened automaticlly after unwind segue
extension MessageVC {
  func getMessageIndexPathToOpen() {
    if firstUserID != nil && secondUserID != nil {
      for message in messages {
        if (message.senderID == firstUserID || message.recipientID == firstUserID) &&
          (message.senderID == secondUserID || message.recipientID == secondUserID) {
          
          messageIDToOpen = message.id
          messageIndexPathToOpen = messages.firstIndex {$0 === message}
          
          print(messageIDToOpen)
          print(messageIndexPathToOpen)
          
          guard let messageID = messageIDToOpen else { return }
          fetchChatMessagesFromSelectedCells(messageID)
          
          firstUserID = nil
          secondUserID = nil
        }
      }
    }
  }
}

//MARK: - Prepare for segue
extension MessageVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goesToChatMessageVC.rawValue {
      guard let destinationVC = segue.destination as? ChatMessageVC else { return }
      destinationVC.chatBubbles = chatMessages
      guard let messageID = messageIDToOpen else { return }
      destinationVC.conversationID = messageID
    }
  }
}

//MARK: - Show cell in bold if messages are not read
extension MessageVC {
  func showBoldMessageIfIsNotRead(in cell: MessageTVC, search message: Message) {
    if (userID == message.senderID && message.isReadBySender == false) ||
      (userID == message.recipientID && message.isReadByRecipient == false ) {
      cell.nameLabel.setupFont(as: .superclarendonBold, sized: .sixteen, forIPad: .twentyThree, in: .typoBlue)
      cell.dateLabel.setupFont(as: .superclarendonBold, sized: .twelve, forIPad: .twenty, in: .middleBlue)
      cell.conversationLabel.setupFont(as: .arialBold, sized: .fifteen, forIPad: .twentyTwo, in: .typoBlue)
    }
    else {
      cell.nameLabel.setupFont(as: .superclarendonBold, sized: .sixteen, forIPad: .twentyThree, in: .typoBlue)
      cell.dateLabel.setupFont(as: .superclarendonLight, sized: .twelve, forIPad: .twenty, in: .middleBlue)
      cell.conversationLabel.setupFont(as: .arial, sized: .fifteen, forIPad: .twentyTwo, in: .typoBlue)
    }
  }
}

//MARK: - Fetch all user messages
extension MessageVC {
  func getAllUserMessagesFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    messages = [Message]()
    triggerActivityIndicator(true)
    let resourcePath = NetworkPath.messages.rawValue + NetworkPath.ofUser.rawValue + userID!
    ResourceRequest<Message>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
          self?.endRefreshing()
          self?.triggerActivityIndicator(false)
        }
      case .success(let messages):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.messages.append(contentsOf: messages)
          self.triggerActivityIndicator(false)
          self.messageTableView.reloadData()
          self.getMessageIndexPathToOpen()
        }
      }
    }
  }
}

//MARK: - Fetch chat messages to be displayed on ChatMessageVC
extension MessageVC {
  func fetchChatMessagesFromSelectedCells(_ messageID: Int) {
    guard UserDefaultsService.shared.userID != nil else { return }
    chatMessages = [ChatMessage]()
    let resourcePath = NetworkPath.messages.rawValue + "\(messageID)/" + NetworkPath.chatMessages.rawValue
    ResourceRequest<ChatMessage>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success(let allChatMessages):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.chatMessages.append(contentsOf: allChatMessages)
          self.performSegue(withIdentifier: Segue.goesToChatMessageVC.rawValue, sender: allChatMessages)
        }
      }
    }
  }
}
