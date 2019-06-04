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
  
  let conversationCellIdentifier = "ConversationTVC"
  let senderCellIdentifier = "SenderTVC"
  
  let messageArray = ["first message", "second message", "Lorem ipsum dolor"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    conversationTableView.delegate = self
    conversationTableView.dataSource = self
    conversationTableView.register(UINib(nibName: conversationCellIdentifier, bundle: nil), forCellReuseIdentifier: conversationCellIdentifier)
    conversationTableView.register(UINib(nibName: senderCellIdentifier, bundle: nil), forCellReuseIdentifier: senderCellIdentifier)
    
    senderMessageTextView.delegate = self
    
    configureTableViewConversationSize()
    setupSenderMessageView()
    setupSenderMessageViewText()
    setTapGestureRecognizer()
  }
}

//MARK: - Send message button action
extension ConversationVC {
  @IBAction func sendMessageButton(_ sender: Any) {
    senderMessageTextView.endEditing(true)
  }
}

//MARK: Setup Table view cells to display messages
extension ConversationVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: senderCellIdentifier, for: indexPath) as! SenderTVC
    
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

extension ConversationVC {
  func setupSenderMessageViewText() {
    senderMessageTextView.font = UIFont(customFont: .messageLabelFont, withSize: .editLabelSize)
    senderMessageTextView.textColor = UIColor.typoBlue
  }
}

//MARK: - Manage cell height depending of its message size
extension ConversationVC {
  func configureTableViewConversationSize() {
    conversationTableView.rowHeight = UITableView.automaticDimension
    conversationTableView.estimatedRowHeight = 120.0
  }
}

//MARK: Move View to handle keyboard when text view is being edited
extension ConversationVC: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    UIView.animate(withDuration: 0.4) {
      self.stackViewBottomConstraint.constant = 268
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
  func setTapGestureRecognizer() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
    conversationTableView.addGestureRecognizer(tapGesture)
  }
  
  @objc func tableViewTapped() {
    senderMessageTextView.endEditing(true)
  }
}
