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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
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

//MARK: - Setup developer main design
extension MessageVC {
  func setupMainDesign() {
    navigationItem.setupNavBarProfileImage()
    setupCustomCell()
    setupEditButton()
  }
}

//MARK: - Setup all delegates
extension MessageVC {
  func setupAllDelegates() {
    messageTableView.delegate = self
    messageTableView.dataSource = self
  }
}

//MARK: Setup Table view cells to display messages
extension MessageVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.messageCellIdentifier.rawValue, for: indexPath) as! MessageTVC
    
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
    performSegue(withIdentifier: Segue.goesToConversationVC.rawValue, sender: self)
  }
}
