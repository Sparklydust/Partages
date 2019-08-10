//
//  MessageVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class MessageVC: UIViewController {
  
  @IBAction func unwindToMessageVC(segue: UIStoryboardSegue) {
    if segue.source is ItemDetailsVC {
      if let senderVC = segue.source as? ItemDetailsVC {
        senderVC.firstUserID = firstUserID ?? ""
        senderVC.secondUserID = secondUserID ?? ""
        print(firstUserID)
        print(secondUserID)
      }
    }
    else if segue.source is ItemSelectedVC {
      if let senderVC = segue.source as? ItemSelectedVC {
        senderVC.firstUserID = firstUserID ?? ""
        senderVC.secondUserID = secondUserID ?? ""
        print(firstUserID)
        print(secondUserID)
      }
    }
  }
  
  @IBOutlet weak var messageTableView: UITableView!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var messages = [Message]()
  
  var firstUserID: String?
  var secondUserID: String?
  
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
    performSegue(withIdentifier: Segue.goesToConversationVC.rawValue, sender: self)
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
    activityIndicator.color = .iceBackground
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
  }
  
  func hideActivityIndicator() {
    activityIndicator.isHidden = true
  }
}

//MARK: - Fetch all user messages
extension MessageVC {
  func getAllUserMessagesFromTheDatabase() {
    guard UserDefaultsService.shared.userID != nil else { return }
    messages = [Message]()
    let userID = UserDefaultsService.shared.userID
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
        }
      }
    }
  }
}
