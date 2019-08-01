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
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var itemsHistory = [DonatedItem]()
  var itemsFavorited = [DonatedItem]()
  var oneDonatedItem: DonatedItem?
  var isHistoryButtonClicked = true
  
  let refreshControl = UIRefreshControl()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    setupLastUserHistoryOrFavoriteChoice()
    checkIfAnUserIsConnected()
    fetchUserItemsHitstory()
    fetchFavoritedItems()
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
      removeUserChosenItem(at: indexPath, on: tableView)
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
    setupRefreshControl()
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
      return itemsFavorited.count
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
      populateItemsFavorited(into: cell, at: indexPath)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    setupItemFromSelectedCell(at: indexPath)
    performSegue(withIdentifier: Segue.goesToItemDetailsVC.rawValue, sender: oneDonatedItem)
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

//MARK: - Activity Indicator action and setup
extension HistoryFavoriteVC {
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

//MARK: - Track the user choice of cell between history and favorite
extension HistoryFavoriteVC {
  func showHistoryCustomCell(_ bool: Bool) {
    isHistoryButtonClicked = bool
    DispatchQueue.main.async {
      self.HistoryFavoriteTableView.reloadData()
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
    guard UserDefaultsService.userID != nil else { return }
    itemsHistory = [DonatedItem]()
    fetchAllDonatedItemsHistory()
    fetchAllReceivedItemsHistory()
  }
}

//MARK: - Fetch all user's donated items
extension HistoryFavoriteVC {
  func fetchAllDonatedItemsHistory() {
    guard let userID = UserDefaultsService.userID else { return }
    triggerActivityIndicator(true)
    let resourcePath = NetworkPath.users.rawValue + userID + "/\(NetworkPath.donatedItems.rawValue)"
    ResourceRequest<DonatedItem>(resourcePath: resourcePath).getAll { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .loadItemError)
          self?.triggerActivityIndicator(false)
        }
      case .success(let donatedItems):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsHistory.append(contentsOf: donatedItems)
          self.triggerActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Fetch all user's received items
extension HistoryFavoriteVC {
  func fetchAllReceivedItemsHistory() {
    guard let userID = UserDefaultsService.userID else { return }
    let resourcePath = NetworkPath.donatedItems.rawValue + NetworkPath.isReceivedBy.rawValue + userID
    triggerActivityIndicator(true)
    ResourceRequest<DonatedItem>(resourcePath: resourcePath).getAllWithToken { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .loadItemError)
          self?.triggerActivityIndicator(false)
        }
      case .success(let receivedItems):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsHistory.append(contentsOf: receivedItems)
          self.HistoryFavoriteTableView.reloadData()
          self.triggerActivityIndicator(false)
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
    let trimmedIsoString = isoDateString.replacingOccurrences(of: StaticLabel.dateOccurence.rawValue, with: StaticLabel.emptyString.rawValue, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    guard let date = dateAndTime?.asString(style: .short) else { return }
    guard let time = dateAndTime?.asString() else { return }
    
    cell.topLabel.text = "\(date)  \(StaticItemDetail.at.rawValue): \(time)"
    cell.bottomLabel.text = donorItem.name
    guard donorItem.isPicked else {
      cell.middleLabel.text = StaticLabel.donationNotSelected.rawValue
      return
    }
    cell.middleLabel.text = StaticLabel.donationIsSelected.rawValue
  }
}

//MARK: - Fetch all user favorited items
extension HistoryFavoriteVC {
  func fetchFavoritedItems() {
    guard UserDefaultsService.userID != nil else { return }
    guard let userID = UserDefaultsService.userID else { return }
    itemsFavorited = [DonatedItem]()
    triggerActivityIndicator(true)
    let resourcePath = "\(NetworkPath.users.rawValue)\(userID)/\(NetworkPath.itemsFavorited.rawValue)"
    ResourceRequest<DonatedItem>(resourcePath: resourcePath).getAll { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .loadItemError)
          self?.triggerActivityIndicator(false)
        }
      case .success(let itemsFavorited):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsFavorited.append(contentsOf: itemsFavorited)
          self.HistoryFavoriteTableView.reloadData()
          self.triggerActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Populate cells with favorited Items from database sorted by date
extension HistoryFavoriteVC {
  func populateItemsFavorited(into cell: FavoriteTVC, at indexPath: IndexPath) {
    itemsFavorited.sort(by: { $0.pickUpDateTime > $1.pickUpDateTime})
    let donorItem = itemsFavorited[indexPath.row]
    
    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(of: StaticLabel.dateOccurence.rawValue, with: StaticLabel.emptyString.rawValue, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    guard let date = dateAndTime?.asString(style: .short) else { return }
    guard let time = dateAndTime?.asString() else { return }
    
    cell.topLabel.text = "\(date)  \(StaticItemDetail.at.rawValue): \(time)"
    cell.bottomLabel.text = donorItem.name
    guard donorItem.isPicked else {
      cell.middleLabel.text = StaticLabel.donationNotSelected.rawValue
      return
    }
    cell.middleLabel.text = StaticLabel.donationIsSelected.rawValue
  }
}

//MARK: - An user delete his favorited item
extension HistoryFavoriteVC {
  func deleteDonatedItemFrom(_ itemsFavorited: DonatedItem) {
    guard UserDefaultsService.userID != nil else { return }
    guard let donatedItemID = itemsFavorited.id else { return }
    triggerActivityIndicator(true)
    DonatedItemRequest(donatedItemID: donatedItemID).deleteLinkBetweenUserAndItemFavorited(UserDefaultsService.userID!) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.triggerActivityIndicator(false)
        }
      case .success:
        DispatchQueue.main.async { [weak self] in
          self?.triggerActivityIndicator(false)
          return
        }
      }
    }
  }
}

//MARK: - Setup one donator item from selected cell to send to ItemSelectedVC
extension HistoryFavoriteVC {
  func setupItemFromSelectedCell(at indexPath: IndexPath) {
    if isHistoryButtonClicked {
      oneDonatedItem = DonatedItem(
        isPicked: itemsHistory[indexPath.row].isPicked,
        selectedType: itemsHistory[indexPath.row].selectedType,
        name: itemsHistory[indexPath.row].name,
        pickUpDateTime: itemsHistory[indexPath.row].pickUpDateTime,
        description: itemsHistory[indexPath.row].description,
        latitude: itemsHistory[indexPath.row].latitude,
        longitude: itemsHistory[indexPath.row].longitude,
        receiverID: itemsHistory[indexPath.row].receiverID
      )
      oneDonatedItem?.id = itemsHistory[indexPath.row].id
    }
    else {
      oneDonatedItem = DonatedItem(
        isPicked: itemsFavorited[indexPath.row].isPicked,
        selectedType: itemsFavorited[indexPath.row].selectedType,
        name: itemsFavorited[indexPath.row].name,
        pickUpDateTime: itemsFavorited[indexPath.row].pickUpDateTime,
        description: itemsFavorited[indexPath.row].description,
        latitude: itemsFavorited[indexPath.row].latitude,
        longitude: itemsFavorited[indexPath.row].longitude,
        receiverID: itemsFavorited[indexPath.row].receiverID
      )
      oneDonatedItem?.id = itemsFavorited[indexPath.row].id
    }
  }
}

//MARK: - Prepare for segue
extension HistoryFavoriteVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? ItemDetailsVC else { return }
    destinationVC.itemDetails = oneDonatedItem
    guard !isHistoryButtonClicked else { return }
  }
}

//MARK: - Manage deletion action from donor or receveiver in history or favorite side
extension HistoryFavoriteVC {
  func removeUserChosenItem(at indexPath: IndexPath, on tableView: UITableView) {
    if isHistoryButtonClicked {
      if itemsHistory[indexPath.row].receiverID == UserDefaultsService.userID {
        receiverUnselect(itemsHistory[indexPath.row])
      }
      else {
        donorDeleteOffTheDatabase(itemsHistory[indexPath.row])
      }
      itemsHistory.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    else {
      deleteDonatedItemFrom(itemsFavorited[indexPath.row])
      itemsFavorited.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}

//MARK: - Receiver remove the item from history and unselect it
extension HistoryFavoriteVC {
  func receiverUnselect(_ donatedItem: DonatedItem?) {
    guard let donatedItemID = donatedItem!.id else { return }
    guard var updatedDonatedItem = donatedItem else { return }
    
    updatedDonatedItem.receiverID = StaticLabel.emptyString.rawValue
    updatedDonatedItem.isPicked = false
    triggerActivityIndicator(true)
    DonatedItemRequest(donatedItemID: donatedItemID).update(with: updatedDonatedItem) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
          self?.triggerActivityIndicator(false)
        }
      case .success(let pickedUpItem):
        DispatchQueue.main.async { [weak self] in
          updatedDonatedItem = pickedUpItem
          self?.showAlert(title: .success, message: .confirmDonatedItemRemoved)
          self?.triggerActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Donor remove the item from history and from the database
extension HistoryFavoriteVC {
  func donorDeleteOffTheDatabase(_ donatedItem: DonatedItem) {
    guard let donatedItemID = donatedItem.id else { return }
    triggerActivityIndicator(true)
    DonatedItemRequest(donatedItemID: donatedItemID).delete()
    triggerActivityIndicator(false)
  }
}

//MARK: - Refresh control method to reload data
extension HistoryFavoriteVC {
  func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(refreshDonatedItems), for: .valueChanged)
    refreshControl.commonDesign(title: .downloadingDonatedItems)
    HistoryFavoriteTableView.addSubview(refreshControl)
  }
  
  @objc private func refreshDonatedItems(_ sender: Any) {
    if isHistoryButtonClicked {
      fetchUserItemsHitstory()
    }
    else {
      fetchFavoritedItems()
    }
    endRefreshing()
  }
  
  func endRefreshing() {
    refreshControl.endRefreshing()
  }
}
