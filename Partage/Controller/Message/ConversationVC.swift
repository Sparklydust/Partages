//
//  ConversationVC.swift
//  Partage
//
//  Created by Roland Lariotte on 03/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ConversationVC: UIViewController {
  
  @IBOutlet weak var senderMessageView: UIView!
  
  @IBOutlet weak var senderMessageTextView: UITextView!
  @IBOutlet weak var conversationTableView: UITableView!
  
  @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var sendMessageButton: UIButton!
  
  var keyboardHeight = CGFloat(0)
  
  let messageArray = ["first message", "second message", "Lorem ipsum dolor"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    tapGestureDismissKeyboard()
    observeKeyboardNotification()
    manageTableViewConversationCellSize()
    conversationTableView.scrollToBottomRow()
  }
}

//MARK: - Send message button action
extension ConversationVC {
  @IBAction func sendMessageButton(_ sender: Any) {
    senderMessageTextView.endEditing(true)
  }
}

//MARK: - Setup developer main design
extension ConversationVC {
  func setupMainDesign() {
    setupAllCustomCells()
    setupSenderMessageView()
    setupSenderMessageViewText()
  }
}

//MARK: - Setup Table view cells to display messages
extension ConversationVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.senderCellIdentifier.rawValue, for: indexPath) as! SenderTVC
    
    cell.senderConversationLabel.text = messageArray[indexPath.row]
    
    return cell
  }
}

//MARK: - Setup sender message view frame
extension ConversationVC {
  func setupSenderMessageView() {
    senderMessageView.layer.cornerRadius = 13
    senderMessageView.layer.borderWidth = 1
    senderMessageView.layer.borderColor = UIColor.typoBlue.cgColor
  }
}

//MARK: - Setup sender message view text field
extension ConversationVC {
  func setupSenderMessageViewText() {
    senderMessageTextView.setupFont(as: .arial, sized: .fifteen, in: .typoBlue)
  }
}

//MARK: - Setup all delegates
extension ConversationVC {
  func setupAllDelegates() {
    conversationTableView.delegate = self
    conversationTableView.dataSource = self
    senderMessageTextView.delegate = self
  }
}

//MARK: - Setup all custom cells
extension ConversationVC {
  func setupAllCustomCells() {
    conversationTableView.setupCustomCell(nibName: .conversationCellIdentifier, identifier: .conversationCellIdentifier)
    conversationTableView.setupCustomCell(nibName: .senderCellIdentifier, identifier: .senderCellIdentifier)
  }
}

//MARK: - Manage cell height depending of its message size
extension ConversationVC {
  func manageTableViewConversationCellSize() {
    conversationTableView.rowHeight = UITableView.automaticDimension
    conversationTableView.estimatedRowHeight = 120.0
  }
}

//MARK: - Move View to handle keyboard when message is being edited
extension ConversationVC: UITextViewDelegate {
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
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    UIView.animate(withDuration: 0.4) {
      self.stackViewBottomConstraint.constant = 10
      self.view.layoutIfNeeded()
    }
  }
}

//MARK: - Tap gesture recognizer declaration
extension ConversationVC {
  func tapGestureDismissKeyboard() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
    conversationTableView.addGestureRecognizer(tapGesture)
  }
  
  @objc func tableViewTapped() {
    senderMessageTextView.endEditing(true)
  }
}
