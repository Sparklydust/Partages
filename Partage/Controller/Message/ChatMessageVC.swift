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
  
  let messageArray = ["first message", "second message", "Lorem ipsum dolor"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    observeKeyboardNotification()
    manageTableViewConversationCellSize()
    conversationTableView.scrollToBottomRow()
  }
}

//MARK: - Send message button action
extension ChatMessageVC {
  @IBAction func sendMessageButton(_ sender: Any) {
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
    setupTapGesture()
    setupSwipeGesture()
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

//MARK: - Setup table view design
extension ChatMessageVC {
  func setupTableViewDesign() {
    conversationTableView.setupMainBackgroundColor()
  }
}

//MARK: - Setup Table view cells to display messages
extension ChatMessageVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.senderCellIdentifier.rawValue, for: indexPath) as! SenderTVC
    
    cell.senderConversationLabel.text = messageArray[indexPath.row]
    
    return cell
  }
}

//MARK: - Setup sender message view frame design
extension ChatMessageVC {
  func setupSenderMessageView() {
    senderMessageView.layer.cornerRadius = 13
    senderMessageView.layer.borderWidth = 1
    senderMessageView.layer.borderColor = UIColor.typoBlue.cgColor
    senderMessageView.setupBackgroundColorIn(.iceBackground)
  }
}

//MARK: - Setup sender message view text field design
extension ChatMessageVC {
  func setupSenderMessageTextView() {
    senderMessageTextView.setupFont(as: .arial, sized: .fifteen, in: .typoBlue)
    senderMessageTextView.setupBackgroundColorIn(.iceBackground)
  }
}

//MARK: - Setup all custom cells design
extension ChatMessageVC {
  func setupAllCustomCells() {
    conversationTableView.setupCustomCell(nibName: .conversationCellIdentifier, identifier: .conversationCellIdentifier)
    conversationTableView.setupCustomCell(nibName: .senderCellIdentifier, identifier: .senderCellIdentifier)
  }
}

//MARK: - Setup tap gesture recognizer
extension ChatMessageVC {
  func setupTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
    conversationTableView.addGestureRecognizer(tapGesture)
  }
  
  @objc func tableViewTapped() {
    senderMessageTextView.endEditing(true)
  }
}

//MARK: - Setup swipe gesture to dismiss keyboard
extension ChatMessageVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    view.endEditing(true)
  }
  
  func setupSwipeGesture() {
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    swipeDown.direction = .down
    view.addGestureRecognizer(swipeDown)
  }
}

//MARK: - Manage cell height depending of its message size
extension ChatMessageVC {
  func manageTableViewConversationCellSize() {
    conversationTableView.rowHeight = UITableView.automaticDimension
    conversationTableView.estimatedRowHeight = 120.0
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
    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue  else { return }
    let keyboardRectangle = keyboardFrame.cgRectValue
    keyboardHeight = keyboardRectangle.height
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    UIView.animate(withDuration: 0.4) {
      self.stackViewBottomConstraint.constant = self.keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)! + 10
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

extension ChatMessageVC {
  
}
