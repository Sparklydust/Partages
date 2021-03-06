//
//  ChatMessageVC.swift
//  Partage
//
//  Created by Roland Lariotte on 03/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ChatMessageVC: UIViewController {

  @IBAction func unwindToConversationVC(segue: UIStoryboardSegue) {}

  @IBOutlet weak var senderMessageView: UIView!
  @IBOutlet weak var senderMessageTextView: UITextView!
  @IBOutlet weak var conversationTableView: UITableView!
  @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var sendMessageButton: UIButton!

  var delegate: CanReceiveInfoMessageIsReadDelegate?

  var keyboardHeight: CGFloat = .zero

  // Match textViewHeight with its height in attribute inspector
  var textViewHeight: CGFloat {
    get {
      guard UIDevice.current.userInterfaceIdiom == .pad else {
        return 150
      }
      return 300
    }
  }

  var userRecipientID = String()

  var chatBubbles = [ChatMessage]()
  var conversationID = Int()
  var conversation: Message?

  var date: String?
  var time: String?
  var dateToShow: String?
  var readLastBubble: Bool?
  var oneUserLeft: Bool?

  var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    observeKeyboardNotification()
    manageTableViewConversationCellSize()
    conversationTableView.scrollToBottomRow()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    conversationTableView.reloadData()
    fetchConversationAttachedToChatBubbles()
    fetchLastChatBubblesIfAnyUsingTimeInterval()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    timer?.invalidate()
    delegate?.confirmMessageIsReadReceived(of: conversationID)
    navigationController?.popToRootViewController(animated: true)
  }
}

//MARK: - Send message button action
extension ChatMessageVC {
  @IBAction func sendMessageButton(_ sender: Any) {
    createNewChatBubble()
    senderMessageTextView.text = StaticLabel.emptyString.description
    senderMessageTextView.endEditing(true)
  }
}

//MARK: - Main setup
extension ChatMessageVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupAllCustomCells()
    setupSenderMessageView()
    setupSenderMessageTextView()
    setupTableViewDesign()
    setupTapAndSwipeGestures()
  }

  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }

  //MARK: All delegates
  func setupAllDelegates() {
    conversationTableView.delegate = self
    conversationTableView.dataSource = self
    senderMessageTextView.delegate = self
  }
}

//MARK: - Setup Table view cells to display messages
extension ChatMessageVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatBubbles.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if chatBubbles[indexPath.row].user == UserDefaultsService.shared.userID {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: CustomCell.SenderTVC.rawValue, for: indexPath) as! SenderTVC
      populateSenderChatBubble(into: cell, at: indexPath)
      return cell
    }
    else {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: CustomCell.ConversationTVC.rawValue, for: indexPath) as! ConversationTVC
      populateConversationChatBubble(into: cell, at: indexPath)
      return cell
    }
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if tableView.isLast(for: indexPath) {
    }
  }
}

//MARK: - Design setup
extension ChatMessageVC {
  //MARK: Setup table view design
  func setupTableViewDesign() {
    conversationTableView.setupMainBackgroundColor()
  }

  //MARK: Setup sender message view frame design
  func setupSenderMessageView() {
    senderMessageView.layer.cornerRadius = 13
    senderMessageView.layer.borderWidth = 1
    if let whiteDarkModeColor = UIColor.iceBackgroundDarkMode,
      let blueTypoBlueDarkModeColor = UIColor.mainBlueTypoBlueDarkMode {
      senderMessageView.setupBackgroundColorIn(whiteDarkModeColor)
      senderMessageView.layer.borderColor = blueTypoBlueDarkModeColor.cgColor
    }
  }

  //MARK: Setup sender message view text field design
  func setupSenderMessageTextView() {
    if let whiteDarkModeColor = UIColor.iceBackgroundDarkMode,
      let typoBlueDarkModeColor = UIColor.typoBlueDarkMode {
      senderMessageTextView.setupBackgroundColorIn(whiteDarkModeColor)
      senderMessageTextView.setupFont(as: .arial, sized: .fifteen, in: typoBlueDarkModeColor)
    }
  }

  //MARK: Setup all custom cells design
  func setupAllCustomCells() {
    conversationTableView.setupCustomCell(nibName: .ConversationTVC, identifier: .ConversationTVC)
    conversationTableView.setupCustomCell(nibName: .SenderTVC, identifier: .SenderTVC)
  }

  //MARK: Setup cell height depending of its message size
  func manageTableViewConversationCellSize() {
    conversationTableView.rowHeight = UITableView.automaticDimension
    conversationTableView.estimatedRowHeight = 120.0
  }
}

//MARK: - Setup tap and swipe gestures recognizer
extension ChatMessageVC {
  func setupTapAndSwipeGestures() {
    setupTapGesture()
    setupSwipeGesture()
  }

  func setupTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
    conversationTableView.addGestureRecognizer(tapGesture)
  }

  @objc func tableViewTapped() {
    senderMessageTextView.endEditing(true)
  }

  func setupSwipeGesture() {
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeDown)
  }

  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    view.endEditing(true)
  }
}

//MARK: - Move View to handle keyboard when message is being edited
extension ChatMessageVC: UITextViewDelegate {
  func observeKeyboardNotification() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
  }

  @objc func keyboardWillShow(_ notification: Notification) {
    guard let keyboardFrame =
      notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardRectangle = keyboardFrame.cgRectValue
    keyboardHeight = keyboardRectangle.height
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    UIView.animate(withDuration: 0.4) {
      self.stackViewBottomConstraint.constant =
        self.keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)! + 10
      self.view.layoutIfNeeded()
    }
    conversationTableView.scrollToBottomRow()
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    UIView.animate(withDuration: 0.4) {
      self.stackViewBottomConstraint.constant = 10
      self.view.layoutIfNeeded()
    }
    conversationTableView.scrollToBottomRow()
  }
}

//MARK: - Method to manage text view height and enable its scrolling option
extension ChatMessageVC {
  func textViewDidChange(_ textView: UITextView) {
    if senderMessageTextView.contentSize.height >= textViewHeight {
      senderMessageTextView.isScrollEnabled = true
      conversationTableView.scrollToBottomRow()
    }
    else {
      senderMessageTextView.frame.size.height = senderMessageTextView.contentSize.height
      senderMessageTextView.isScrollEnabled = false
      conversationTableView.scrollToBottomRow()
    }
  }
}

//MARK: - Method to populate the cells with specific bubble chat
extension ChatMessageVC {
  func populateSenderChatBubble(into cell: SenderTVC, at indexPath: IndexPath) {
    let bubble = chatBubbles[indexPath.row]

    let isoDateString = bubble.date
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    date = dateAndTime!.asString(style: .short)
    time = dateAndTime!.asString()
    if dateAndTime!.isGreaterThanDate(dateToCompare: Date()) {
      dateToShow = "\(date!)  \(time!)"
    }
    else {
      dateToShow = "\(time!)"
    }
    cell.senderConversationLabel.text = bubble.content
  }

  func populateConversationChatBubble(into cell: ConversationTVC, at indexPath: IndexPath) {
    let bubble = chatBubbles[indexPath.row]

    let isoDateString = bubble.date
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    if let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString) {
      date = dateAndTime.asString(style: .short)
      time = dateAndTime.asString()
      if dateAndTime.isGreaterThanDate(dateToCompare: Date()) {
        dateToShow = "\(date!)  \(time!)"
      }
      else {
        dateToShow = "\(time!)"
      }
    }
    cell.conversationLabel.text = bubble.content
    fetchUserRecipientPicture(from: conversationID, at: indexPath)
  }
}

//MARK: - Boolean to check if one user left a conversation
extension ChatMessageVC {
  func oneUserLeftConversation(_ message: Message) -> Bool {
    guard message.senderID == StaticLabel.emptyString.description ||
      message.recipientID == StaticLabel.emptyString.description else { return false }
    return true
  }
}

//MARK: - Add one more cell with info that user left the conversation
extension ChatMessageVC {
  func showNewCellSayingUserLeft() {
    let userLeftChat = ChatMessage(
      user: StaticLabel.emptyString.description,
      date: StaticLabel.emptyString.description,
      content: StaticLabel.userLeftTheConversation.description,
      messageID: 0
    )
    chatBubbles.append(userLeftChat)
    timer?.invalidate()

    conversationTableView.beginUpdates()
    conversationTableView.insertRows(
      at: [IndexPath.init(row: chatBubbles.count - 1, section: 0)], with: .automatic)
    conversationTableView.endUpdates()
  }
}

//MARK: - API calls
extension ChatMessageVC {
  //MARK: Create a chat message and update Message in the database
  func createNewChatBubble() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let userID = UserDefaultsService.shared.userID else { return }
    guard let chatMessage = senderMessageTextView.text else { return }
    let dateAndTime = ISO8601DateFormatter.string(
      from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)

    let newChatBubble = ChatMessage(
      user: userID,
      date: dateAndTime,
      content: chatMessage,
      messageID: conversationID)

    let resourcePath = NetworkPath.chatMessages.description
    ResourceRequest<ChatMessage>(resourcePath).save(newChatBubble, tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success:
        self.updateConversationToNewMessageInfo()
      }
    }
  }

  //MARK: Fetch the conversation message attached to chat bubbles
  func fetchConversationAttachedToChatBubbles() {
    guard UserDefaultsService.shared.userID != nil else { return }
    let resourcePath = NetworkPath.messages.description + "\(conversationID)"
    ResourceRequest<Message>(resourcePath).get(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success(let conversationFetch):
        DispatchQueue.main.async { [weak self] in
          self?.conversation = conversationFetch
          self?.oneUserLeft = self?.oneUserLeftConversation(conversationFetch)
          self?.updateConversationMessagesToReadByUser()

          if self!.oneUserLeft! {
            self?.showNewCellSayingUserLeft()
          }
        }
      }
    }
  }

  //MARK: Update conversation message info to the latest chatMessage
  func updateConversationToNewMessageInfo() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let conversationToUpdate = conversation else { return }

    let dateAndTime = ISO8601DateFormatter.string(
      from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)

    if conversationToUpdate.senderID == UserDefaultsService.shared.userID {
      readLastBubble = true
    }
    else {
      readLastBubble = false
    }

    let newConversationInfo = Message(
      senderID: conversationToUpdate.senderID,
      recipientID: conversationToUpdate.recipientID,
      date: dateAndTime,
      isReadBySender: readLastBubble!,
      isReadByRecipient: !readLastBubble!
    )

    let resourcePath = NetworkPath.messages.description + "\(conversationID)"
    ResourceRequest<Message>(resourcePath).update(newConversationInfo, tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success:
        break
      }
    }
  }

  //MARK: Update conversation messages to read by user
  func updateConversationMessagesToReadByUser() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let conversationToUpdate = conversation else { return }

    let userID = UserDefaultsService.shared.userID
    if userID == conversationToUpdate.senderID {
      conversationToUpdate.isReadBySender = true
    }
    else {
      conversationToUpdate.isReadByRecipient = true
    }

    let messagesAreRead = Message(
      senderID: conversationToUpdate.senderID,
      recipientID: conversationToUpdate.recipientID,
      date: conversationToUpdate.date,
      isReadBySender: conversationToUpdate.isReadBySender,
      isReadByRecipient: conversationToUpdate.isReadByRecipient
    )

    let resourcePath = NetworkPath.messages.description + "\(conversationID)"
    ResourceRequest<Message>(resourcePath).update(messagesAreRead, tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
        }
      case .success:
        break
      }
    }
  }

  //MARK: Fetch chat messages to be displayed on ChatMessageVC
  func fetchAllChatBubblesForTheTimerIntervalFrom(_ messageID: Int) {
    guard UserDefaultsService.shared.userID != nil else { return }
    let countBubbles = chatBubbles.count

    let resourcePath =
      NetworkPath.messages.description + "\(messageID)/" + NetworkPath.chatMessages.description
    ResourceRequest<ChatMessage>(resourcePath).getAll(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        break
      case .success(let allChatMessages):
        DispatchQueue.main.async { [weak self] in
          if countBubbles < allChatMessages.count {
            self?.chatBubbles = [ChatMessage]()
            self?.chatBubbles.append(contentsOf: allChatMessages)
            self?.conversationTableView.reloadData()
            self?.conversationTableView.scrollToBottomRow()
          }
        }
      }
    }
  }
  
  //MARK: To get user recipient ID to show recipient profile picture
  func fetchUserRecipientPicture(from conversationID: Int, at indexPath: IndexPath) {
    let userID = UserDefaultsService.shared.userID
    let resourcePath = NetworkPath.messages.description + "\(conversationID)"
    ResourceRequest<Message>(resourcePath).get(tokenNeeded: true) { (success) in
      switch success {
      case .failure:
        break
      case .success(let message):
        DispatchQueue.global(qos: .utility).async {
          if userID == message.senderID {
            self.userRecipientID = message.recipientID
            print("😎\(self.userRecipientID)")
          }
          else {
            self.userRecipientID = message.senderID
            print("😅\(self.userRecipientID)")
          }
          DispatchQueue.main.async {
            if let cell = self.conversationTableView.cellForRow(at: indexPath) as? ConversationTVC {
              FirebaseStorageHandler.shared.downloadProfilePicture(of: self.userRecipientID, in: cell)
            }
          }
        }
      }
    }
  }
}

//MARK: - Timer interval to fetch new chat bubbles
extension ChatMessageVC {
  func fetchLastChatBubblesIfAnyUsingTimeInterval() {
    timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (_) in
      DispatchQueue.main.async {
        self.fetchAllChatBubblesForTheTimerIntervalFrom(self.conversationID)
      }
    })
  }
}
