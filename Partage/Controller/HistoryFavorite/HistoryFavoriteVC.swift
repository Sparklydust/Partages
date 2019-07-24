//
//  HistorySavingVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class HistoryFavoriteVC: UIViewController {
  
  @IBOutlet weak var HistoryFavoriteTableView: UITableView!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var historyButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  var itemsHistory = [DonatedItem]()
  var favoriteItems = [DonatedItem]()
  var isHistoryButtonClicked = true
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    checkIfAnUserIsConnected()
    fetchUserItemsHitstory()
    HistoryFavoriteTableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    setupLastUserHistoryOrFavoriteChoice()
  }
}

//MARK: - Buttons actions
extension HistoryFavoriteVC {
  //MARK: History button action
  @IBAction func historyButton(_ sender: Any) {
    setupHistoryButtonIsSelected()
    showHistoryCustomCell(true)
  }
  
  //MARK: Favorite button action
  @IBAction func favoriteButton(_ sender: Any) {
    setupFavoriteButtonIsSelected()
    showHistoryCustomCell(false)
  }
  
  //MARK: Edit button action
  @IBAction func editButton(_ sender: UIBarButtonItem) {
    UIView.animate(withDuration: 0.3) {
      self.HistoryFavoriteTableView.isEditing = !self.HistoryFavoriteTableView.isEditing
      sender.title = (self.HistoryFavoriteTableView.isEditing) ? ButtonName.done.rawValue : ButtonName.edit.rawValue
    }
  }
}

//MARK: - Swipe to delete cell action
extension HistoryFavoriteVC {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      
      
      
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = .iceBackground
  }
}

//MARK: - Main setup
extension HistoryFavoriteVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupEditButton()
    setupAllCustomCells()
    setupNavigationController()
    setupTableViewDesign()
    setupCellSizeForIPad()
  }
  
  //MARK: Main view design
  func setupMainView() {
    view.setupMainBackgroundColor()
  }
  
  //MARK: All delegates
  func setupAllDelegates() {
    HistoryFavoriteTableView.delegate = self
    HistoryFavoriteTableView.dataSource = self
  }
}

//MARK: - Setup Table View
extension HistoryFavoriteVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isHistoryButtonClicked {
      return itemsHistory.count
    }
    else {
      return favoriteItems.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if isHistoryButtonClicked {
      let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.historyCellIdentifier.rawValue, for: indexPath) as! HistoryTVC
      
      populateItemsHistory(into: cell, at: indexPath)
      
      return cell
    }
    else {
      let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.favoriteCellIdentifier.rawValue, for: indexPath) as! FavoriteTVC
      
      return cell
    }
  }
}

//MARK: - Setup table view design
extension HistoryFavoriteVC {
  func setupTableViewDesign() {
    HistoryFavoriteTableView.setupMainBackgroundColor()
  }
}

//MARK: - Setup edit button design
extension HistoryFavoriteVC {
  func setupEditButton() {
    editButton.editButtonDesign()
  }
}

//MARK: - Setup history button is selected design
extension HistoryFavoriteVC {
  func setupHistoryButtonIsSelected() {
    UIView.animate(withDuration: 0.3) {
      self.historyButton.historyFavoriteSelectedDesign(named: .history)
      self.favoriteButton.historyFavoriteUnselectedDesign(named: .favorite)
    }
  }
}

//MARK: - Setup favorite button is selected design
extension HistoryFavoriteVC {
  func setupFavoriteButtonIsSelected() {
    UIView.animate(withDuration: 0.3) {
      self.favoriteButton.historyFavoriteSelectedDesign(named: .favorite)
      self.historyButton.historyFavoriteUnselectedDesign(named: .history)
    }
  }
}

//MARK: - Setup navigation controller design
extension HistoryFavoriteVC {
  func setupNavigationController() {
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.tintColor = .typoBlue
    navigationController?.navigationBar.barTintColor = .iceBackground
    navigationController?.navigationBar.isTranslucent = false
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup cell size for iPad
extension HistoryFavoriteVC {
  func setupCellSizeForIPad() {
    if UIDevice.current.userInterfaceIdiom == .pad {
      HistoryFavoriteTableView.rowHeight = 150
    }
  }
}

//MARK: - Setup all custom cells design
extension HistoryFavoriteVC {
  func setupAllCustomCells() {
    HistoryFavoriteTableView.setupCustomCell(nibName: .historyCellIdentifier, identifier: .historyCellIdentifier)
    HistoryFavoriteTableView.setupCustomCell(nibName: .favoriteCellIdentifier, identifier: .favoriteCellIdentifier)
  }
}

//MARK: - Setup last user choice when view Controller is left
extension HistoryFavoriteVC {
  func setupLastUserHistoryOrFavoriteChoice() {
    if favoriteButton.isEnabled {
      setupHistoryButtonIsSelected()
    }
    else {
      setupFavoriteButtonIsSelected()
    }
  }
}

//MARK: - Track the user choice of cell between history and favorite
extension HistoryFavoriteVC {
  func showHistoryCustomCell(_ bool: Bool) {
    isHistoryButtonClicked = bool
    DispatchQueue.main.async {
      self.HistoryFavoriteTableView.reloadData()
    }
  }
}

//MARK: - Perform history or favorite segue when row is selected
extension HistoryFavoriteVC {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: Segue.goesToItemDetailsVC.rawValue, sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segue.goesToItemDetailsVC.rawValue {
    }
  }
}

//MARK: - Check if an user is connected, else send him to SignInVC
extension HistoryFavoriteVC {
  func checkIfAnUserIsConnected() {
    guard UserDefaultsService.token != nil else {
      showAlert(title: .restricted, message: .notConnected) { (true) in
        self.performSegue(withIdentifier: Segue.goesToSignInSignUpVC.rawValue, sender: self)
      }
      return
    }
  }
}

//MARK: - Fetch all user items history
extension HistoryFavoriteVC {
  func fetchUserItemsHitstory() {
    fetchAllDonatedItemsHistory()
    fetchAllReceivedItemsHistory()
  }
}

//MARK: - Fetch all user's donated items
extension HistoryFavoriteVC {
  func fetchAllDonatedItemsHistory() {
    guard UserDefaultsService.userID != nil else { return }
    guard let userID = UserDefaultsService.userID else { return }
    
    let resourcePath = NetworkPath.users.rawValue + userID + "/\(NetworkPath.donatedItems.rawValue)"
    
    ResourceRequest<DonatedItem>(resourcePath: resourcePath).getAll { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .loadItemError)
        }
      case .success(let donatedItems):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsHistory.append(contentsOf: donatedItems)
        }
      }
    }
  }
}

//MARK: - Fetch all user's received items
extension HistoryFavoriteVC {
  func fetchAllReceivedItemsHistory() {
    guard UserDefaultsService.userID != nil else { return }
    guard let userID = UserDefaultsService.userID else { return }
    
    let resourcePath = NetworkPath.users.rawValue + userID + NetworkPath.receivedItems.rawValue
    
    ResourceRequest<DonatedItem>(resourcePath: resourcePath).getAll { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .loadItemError)
        }
      case .success(let receivedItems):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsHistory.append(contentsOf: receivedItems)
        }
      }
    }
  }
}

//MARK: - Populate cells with donators Items from database sorted by date
extension HistoryFavoriteVC {
  func populateItemsHistory(into cell: HistoryTVC, at indexPath: IndexPath) {
    itemsHistory.sort(by: { $0.pickUpDateTime > $1.pickUpDateTime})
    
    let donorItem = itemsHistory[indexPath.row]

    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    guard let date = dateAndTime?.asString(style: .short) else { return }
    guard let time = dateAndTime?.asString() else { return }
    
    cell.topLabel.text = "\(StaticItemDetail.the.rawValue): \(date)  \(StaticItemDetail.at.rawValue): \(time)"
    cell.middleLabel.text = donorItem.selectedType
    cell.bottomLabel.text = donorItem.name
  }
}
