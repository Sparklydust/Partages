//
//  MessageVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import TableViewReloadAnimation

class MessageVC: UIViewController {
  
  @IBOutlet weak var messageTableView: UITableView!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var userID = String()
  var userFetch = String()
  
  var messages = [Message]()
  var chatMessages = [ChatMessage]()
  var lastChatBubbleID = Int()
  var newChatBubbleArrived = Bool()
  
  var firstUserID: String?
  var secondUserID: String?
  var messageIDToOpen: Int?
  var messageIndexPathToOpen: Int?
  
  var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    triggerActivityIndicator(false)
    checkIfAnUserIsConnected()
    getAllUserMessagesFromTheDatabase()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getAllUserMessagesBeforeTimerStarts()
    fetchLastMessagesIfAnyUsingTimeInterval()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    timer?.invalidate()
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
      deleteMessageFromCell(at: indexPath, on: tableView)
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
    
    let messageInfo = messages[indexPath.row]
    
    showMessageInBoldIfNotRead(in: cell, search: messageInfo)
    populateUser(in: cell, from: messageInfo)
    populateDateOrTime(in: cell, with: messageInfo.date)
    if let messageID = messageInfo.id {
      populateConversationLabel(in: cell, search: messageID)
    }
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
    userID = UserDefaultsService.shared.userID!
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

//MARK: - Found index path of message to be opened automatically after unwind segue has performed
extension MessageVC {
  func getMessageIndexPathToOpen() {
    if firstUserID != nil && secondUserID != nil {
      for message in messages {
        if (message.senderID == firstUserID || message.recipientID == firstUserID) &&
          (message.senderID == secondUserID || message.recipientID == secondUserID) {

          messageIDToOpen = message.id
          messageIndexPathToOpen = messages.firstIndex {$0 === message}
          
          if let indexPathToOpen = messageIndexPathToOpen {
            let indexPath = IndexPath.init(row: indexPathToOpen, section: 0)
            messageTableView.scrollToRow(at: indexPath, at: .none, animated: true)
          }
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
      destinationVC.delegate = self
      destinationVC.chatBubbles = chatMessages
      guard let messageID = messageIDToOpen else { return }
      destinationVC.conversationID = messageID
      if firstUserID == UserDefaultsService.shared.userID {
        destinationVC.userRecipientID = userFetch
      }
      else {
        destinationVC.userRecipientID = userFetch
      }
    }
  }
}

//MARK: - Show cell in bold if messages are not read
extension MessageVC {
  func showMessageInBoldIfNotRead(in cell: MessageTVC, search message: Message) {
    if (userID == message.senderID && message.isReadBySender == false) ||
      (userID == message.recipientID && message.isReadByRecipient == false ) {
      cell.nameLabel.setupFont(as: .superclarendonBold, sized: .sixteen, forIPad: .twentyThree, in: .typoBlue)
      cell.dateLabel.setupFont(as: .superclarendonBold, sized: .twelve, forIPad: .twenty, in: .mainBlue)
      cell.conversationLabel.setupFont(as: .arialBold, sized: .fifteen, forIPad: .twentyTwo, in: .typoBlue)
      cell.profileImage.roundedWithMainBlueBorder()
    }
    else {
      cell.nameLabel.setupFont(as: .superclarendonBold, sized: .sixteen, forIPad: .twentyThree, in: .typoBlue)
      cell.dateLabel.setupFont(as: .superclarendonLight, sized: .twelve, forIPad: .twenty, in: .middleBlue)
      cell.conversationLabel.setupFont(as: .arial, sized: .fifteen, forIPad: .twentyTwo, in: .typoBlue)
      cell.profileImage.roundedWithMiddleBlueBorder()
    }
  }
}

//MARK: - Set info cell if one user left the conversation to close
extension MessageVC {
  func setConversationIsClosed(in cell: MessageTVC) {
    cell.nameLabel.setupFont(as: .superclarendonLight, sized: .sixteen, forIPad: .twentyThree, in: .typoBlue)
    cell.nameLabel.text = StaticLabel.closedConversation.rawValue
  }
}

//MARK: - Delete Link of user to delete message from table view
extension MessageVC {
  func deleteMessageFromCell(at indexPath: IndexPath, on tableView: UITableView) {
    updateToDeleteUserLink(in: messages[indexPath.row])
    messages.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }
}

//MARK: - Fetch all user messages
extension MessageVC {
  func getAllUserMessagesFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    
    triggerActivityIndicator(true)
    let resourcePath = NetworkPath.messages.rawValue + NetworkPath.ofUser.rawValue + userID
    ResourceRequest<Message>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
          self?.triggerActivityIndicator(false)
        }
      case .success(let uncomingMessages):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.messages = [Message]()
          self.messages.append(contentsOf: uncomingMessages)
          self.triggerActivityIndicator(false)
          self.reloadDataWithAnimation()
          self.getMessageIndexPathToOpen()
        }
      }
    }
  }
}

//MARK: - Fetch all user messages
extension MessageVC {
  func getAllUserMessagesBeforeTimerStarts() {
    guard UserDefaultsService.shared.userID != nil else { return }
    
    triggerActivityIndicator(true)
    let resourcePath = NetworkPath.messages.rawValue + NetworkPath.ofUser.rawValue + userID
    ResourceRequest<Message>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        break
      case .success(let uncomingMessages):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.messages = [Message]()
          self.messages.append(contentsOf: uncomingMessages)
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

//MARK: - Delete user message link by updating and deleting his userID
extension MessageVC {
  func updateToDeleteUserLink(in message: Message) {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let messageID = message.id else { return }
    
    if userID == message.senderID {
      message.senderID = StaticLabel.emptyString.rawValue
    }
    else {
      message.recipientID = StaticLabel.emptyString.rawValue
    }
    
    let linkUserToMessage = Message(
      senderID: message.senderID,
      recipientID: message.recipientID,
      date: message.date,
      isReadBySender: message.isReadBySender,
      isReadByRecipient: message.isReadByRecipient
    )
    
    let resourcePath = NetworkPath.messages.rawValue + "\(messageID)"
    ResourceRequest<Message>(resourcePath).update(linkUserToMessage, tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success(let updatedMessage):
        DispatchQueue.main.async { [weak self] in
          guard updatedMessage.recipientID == StaticLabel.emptyString.rawValue &&
            updatedMessage.senderID == StaticLabel.emptyString.rawValue else { return }
          self?.delete(updatedMessage)
        }
      }
    }
  }
}

//MARK: - Fetch all user messages when the timer trigger
extension MessageVC {
  func getAllUserMessagesForTheTimerInterval() {
    guard UserDefaultsService.shared.userID != nil else { return }
    let countMessages = messages.count
    let lastMessageID = messages.last?.id
    
    if let conversation = lastMessageID {
      fetchChatMessagesToTrackNewBubble(of: conversation)
    }
    let resourcePath = NetworkPath.messages.rawValue + NetworkPath.ofUser.rawValue + userID
    ResourceRequest<Message>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        break
      case .success(let incomingMessages):
        DispatchQueue.main.async { [weak self] in
          if countMessages < incomingMessages.count || lastMessageID != incomingMessages.last?.id || self!.newChatBubbleArrived {
            self?.messages = [Message]()
            self?.messages.append(contentsOf: incomingMessages)
            self?.messageTableView.reloadData()
          }
        }
      }
    }
  }
}

//MARK: - Fetch chat messages to tack if new message need to be reloaded
extension MessageVC {
  func fetchChatMessagesToTrackNewBubble(of messageID: Int) {
    guard UserDefaultsService.shared.userID != nil else { return }
    
    if let id = chatMessages.last?.id {
      lastChatBubbleID = id
    }
    let resourcePath = NetworkPath.messages.rawValue + "\(messageID)/" + NetworkPath.chatMessages.rawValue
    ResourceRequest<ChatMessage>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        break
      case .success(let allChatMessages):
        DispatchQueue.main.async { [weak self] in
          self?.chatMessages = [ChatMessage]()
          self?.chatMessages.append(contentsOf: allChatMessages)
          self?.trackNewChatBubbleArrived(from: allChatMessages)
        }
      }
    }
  }
}

//MARK: - Delete a message if any user left linked to it
extension MessageVC {
  func delete(_ message: Message) {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let messageID = message.id else { return }
    
    let resourcePath = NetworkPath.messages.rawValue + "\(messageID)"
    ResourceRequest<Message>(resourcePath).delete(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success:
        return
      }
    }
  }
}

//MARK: - To populate user first name linked to the message
extension MessageVC {
  func populateUser(in cell: MessageTVC, from messageInfo: Message) {
    
    if userID == messageInfo.senderID {
      userFetch = messageInfo.recipientID
    }
    else {
      userFetch = messageInfo.senderID
    }
    
    if userFetch != StaticLabel.emptyString.rawValue {
      let resourcePathToUser = NetworkPath.users.rawValue + userFetch
      ResourceRequest<User>(resourcePathToUser).get(tokenNeeded: true) { (success) in
        switch success {
        case .failure:
          DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: .error, message: .networkRequestError)
          }
        case .success(let userFetched):
          DispatchQueue.main.async {
            cell.nameLabel.text = userFetched.firstName
            FirebaseStorageHandler.shared.downloadProfilePicture(of: userFetched.id!.uuidString, into: cell)
          }
        }
      }
    }
    else {
      setConversationIsClosed(in: cell)
    }
  }
}

//MARK: - To populate a cell with the last chat bubble message
extension MessageVC {
  func populateConversationLabel(in cell: MessageTVC, search messageID: Int) {
    let resourcePathToLastChat = NetworkPath.messages.rawValue + "\(messageID)/" + NetworkPath.chatMessages.rawValue
    ResourceRequest<ChatMessage>(resourcePathToLastChat).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success(let chatMessages):
        DispatchQueue.main.async {
          cell.conversationLabel.text = chatMessages.last?.content
        }
      }
    }
  }
}

//MARK: - To populate date or time in each message cell
extension MessageVC {
  func populateDateOrTime(in cell: MessageTVC, with isoDateString: String) {
    var date: String
    var time: String
    var dateToShow: String
    
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
  }
}

//MARK: - Timer interval to fetch new user messages
extension MessageVC {
  func fetchLastMessagesIfAnyUsingTimeInterval() {
    timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (_) in
      DispatchQueue.main.async {
        self.getAllUserMessagesForTheTimerInterval()
      }
    })
  }
}

//MARK: - Check if last message chat bubble has changed for a new bubble
extension MessageVC {
  func trackNewChatBubbleArrived(from allChatMessages: [ChatMessage]) {
    if self.lastChatBubbleID == allChatMessages.last?.id {
      self.newChatBubbleArrived = true
    }
    else {
      self.newChatBubbleArrived = false
    }
  }
}

//MARK: - Receive info from protocol that last message was read in ChatMessageVC
extension MessageVC: CanReceiveInfoMessageIsReadDelegate {
  func confirmMessageIsReadReceived(of messageID: Int) {
    fetchOneMessageTobeUpdateAsRead(messageID)
  }
}

//MARK: - Fetch last read message before being update to read by user
extension MessageVC {
  func fetchOneMessageTobeUpdateAsRead(_ messageID: Int) {
    guard UserDefaultsService.shared.userID != nil else { return }
    
    let resourcePath = NetworkPath.messages.rawValue + "\(messageID)"
    ResourceRequest<Message>(resourcePath).get(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        break
      case .success(let message):
        DispatchQueue.main.async {
          self.updateToReadByUser(this: message)
        }
      }
    }
  }
}

//MARK: - Update conversation messages to read by user
extension MessageVC {
  func updateToReadByUser(this message: Message) {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let messageID = message.id else { return }
    
    let userID = UserDefaultsService.shared.userID
    if userID == message.senderID {
      message.isReadBySender = true
    }
    else {
      message.isReadByRecipient = true
    }
    let messagesAreRead = Message(
      senderID: message.senderID,
      recipientID: message.recipientID,
      date: message.date,
      isReadBySender: message.isReadBySender,
      isReadByRecipient: message.isReadByRecipient
    )
    
    let resourcePath = NetworkPath.messages.rawValue + "\(messageID)"
    ResourceRequest<Message>(resourcePath).update(messagesAreRead, tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        break
      case .success:
        break
      }
    }
  }
}

//MARK: - Reload data with an animation
extension MessageVC {
  func reloadDataWithAnimation() {
    messageTableView.reloadData(with: .simple(duration: 0.45, direction: .rotation3D(type: .ironMan), constantDelay: 0))
  }
}
