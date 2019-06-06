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
  
  let messageCellIdentifier = "MessageTVC"
  var customCell = MessageTVC()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAllDelegates()
    setupCustomCell()
    setupEditButton()
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Delete message cell with Edit button or by swaping left on it
extension MessageVC {
  @IBAction func editButton(_ sender: UIBarButtonItem) {
    UIView.animate(withDuration: 0.3) {
      self.messageTableView.isEditing = !self.messageTableView.isEditing
      sender.title = (self.messageTableView.isEditing) ? "Done" : "Edit"
    }
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = UIColor.iceBackground
  }
}

//MARK: Setup Table view cells to display messages
extension MessageVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: messageCellIdentifier, for: indexPath) as! MessageTVC
    
    return cell
  }
}

//MARK: - Setup Edit button in navigation bar
extension MessageVC {
  func setupEditButton() {
    editButton.title = ButtonName.edit.rawValue
    editButton.setTitleTextAttributes(
      [NSAttributedString.Key.font: UIFont(
        customFont: .arialBold, withSize: .fifteen)!,
       NSAttributedString.Key.foregroundColor: UIColor.typoBlue],
      for: .normal)
  }
}

//MARK: - Setup all delegates
extension MessageVC {
  func setupAllDelegates() {
    messageTableView.delegate = self
    messageTableView.dataSource = self
  }
}

//MARK: - Setup all custom cells
extension MessageVC {
  func setupCustomCell() {
        messageTableView.register(UINib(nibName: messageCellIdentifier, bundle: nil), forCellReuseIdentifier: messageCellIdentifier)
  }
}

//MARK: - Segue action
extension MessageVC {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToConversationVC", sender: self)
  }
}
