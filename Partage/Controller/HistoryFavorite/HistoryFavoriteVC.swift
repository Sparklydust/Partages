//
//  HistorySavingVC.swift
//  Partage
//
//  Created by Roland Lariotte on 29/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import TableViewReloadAnimation

class HistoryFavoriteVC: UIViewController {

  @IBAction func unwindToHistoryFavoriteVC(segue: UIStoryboardSegue) { }

  @IBOutlet weak var HistoryFavoriteTableView: UITableView!
  @IBOutlet weak var editButton: UIBarButtonItem!
  @IBOutlet weak var historyButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var noHistoryOrFavoriteInfo: UILabel!

  var userDonatedItems = [DonatedItem]()
  var userReceivedItems = [DonatedItem]()
  var itemsHistory = [DonatedItem]()
  var itemsFavorited = [DonatedItem]()
  var oneDonatedItem: DonatedItem?
  var isHistoryButtonClicked = true

  let refreshControl = UIRefreshControl()
  var refreshControlTriggered = false

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    fetchHistoryAndFavoritedItems()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    setupLastUserHistoryOrFavoriteChoice()
    triggerActivityIndicator(false)
    AppStoreReviewHandler.shared.requestReviewIfAppropriate()
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
      sender.title = (
        self.HistoryFavoriteTableView.isEditing) ? ButtonName.done.description : ButtonName.edit.description
    }
  }
}

//MARK: - Swipe to delete cell action
extension HistoryFavoriteVC {
  func tableView(
    _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      removeUserChosenItem(at: indexPath, on: tableView)
    }
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = .iceBackgroundDarkMode
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
    setupNoHistoryOrFavoriteInfo()
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
      let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.HistoryTVC.rawValue, for: indexPath) as! HistoryTVC
      populateItemsHistory(into: cell, at: indexPath)
      FirebaseStorageHandler.shared.downloadItemImage(of: itemsHistory[indexPath.row], into: cell.itemImage)
      return cell
    }
    else {
      let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.FavoriteTVC.rawValue, for: indexPath) as! FavoriteTVC
      populateItemsFavorited(into: cell, at: indexPath)
      FirebaseStorageHandler.shared.downloadItemImage(of: itemsFavorited[indexPath.row], into: cell.itemImage)
      return cell
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    setupItemFromSelectedCell(at: indexPath)
    performSegue(withIdentifier: Segue.goToItemDetailsVC.rawValue, sender: oneDonatedItem)
  }
}

//MARK: - Design setup
extension HistoryFavoriteVC {
  //MARK: Setup table view design
  func setupTableViewDesign() {
    HistoryFavoriteTableView.setupMainBackgroundColor()
  }

  //MARK: Setup edit button design
  func setupEditButton() {
    editButton.editButtonDesign()
  }

  //MARK: Setup history button is selected design
  func setupHistoryButtonIsSelected() {
    UIView.animate(withDuration: 0.3) {
      self.historyButton.historyFavoriteSelectedDesign(named: .history)
      self.favoriteButton.historyFavoriteUnselectedDesign(named: .favorite)
    }
  }

  //MARK: Setup favorite button is selected design
  func setupFavoriteButtonIsSelected() {
    UIView.animate(withDuration: 0.3) {
      self.favoriteButton.historyFavoriteSelectedDesign(named: .favorite)
      self.historyButton.historyFavoriteUnselectedDesign(named: .history)
    }
  }

  //MARK: Setup navigation controller design
  func setupNavigationController() {
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.tintColor = .typoBlueDarkMode
    navigationController?.navigationBar.barTintColor = .iceBackgroundDarkMode
    navigationController?.navigationBar.isTranslucent = false
  }

  //MARK: Setup cell size for iPad
  func setupCellSizeForIPad() {
    if UIDevice.current.userInterfaceIdiom == .pad {
      HistoryFavoriteTableView.rowHeight = 150
    }
  }

  //MARK: - Setup label if user has no history or favorite
  func setupNoHistoryOrFavoriteInfo() {
    if let darkModeColor = UIColor.typoBlueDarkMode {
      noHistoryOrFavoriteInfo.setupFont(
        as: .arial, sized: .heighteen, forIPad: .twentyFive, in: darkModeColor)
    }
    noHistoryOrFavoriteInfo.textAlignment = .center
    noHistoryOrFavoriteInfo.text = nil
  }
}

//MARK: - Setup all custom cells design
extension HistoryFavoriteVC {
  func setupAllCustomCells() {
    HistoryFavoriteTableView.setupCustomCell(nibName: .HistoryTVC, identifier: .HistoryTVC)
    HistoryFavoriteTableView.setupCustomCell(nibName: .FavoriteTVC, identifier: .FavoriteTVC)
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
    activityIndicator.style = UIActivityIndicatorView.Style.large
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
    if isHistoryButtonClicked {
      DispatchQueue.main.async {
        self.reloadHistoryItems()
        self.noHistoryOrFavoriteInfoIfNeeded()
      }
    }
    else {
      DispatchQueue.main.async {
        self.reloadFavoritedItems()
        self.noHistoryOrFavoriteInfoIfNeeded()
      }
    }
  }
}

//MARK: - Check if an user is connected, else send him to SignInVC
extension HistoryFavoriteVC {
  func checkIfAnUserIsConnected() {
    guard UserDefaultsService.shared.userToken != nil else {
      emptyTableViewForDisconnectedUser()
      showAlert(title: .restrictedTitle, message: .notConnected) { (true) in
        self.performSegue(withIdentifier: Segue.goToSignInSignUpVC.rawValue, sender: self)
      }
      return
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

//MARK: - API calls
extension HistoryFavoriteVC {
  //MARK: Fetch all user's donated items
  func fetchAllDonatedItemsHistory(_ completionHandler: @escaping () -> ()) {
    guard let userID = UserDefaultsService.shared.userID else { return }
    if !refreshControlTriggered {
      triggerActivityIndicator(true)
    }
    
    let resourcePath =
      NetworkPath.users.description + userID + "/\(NetworkPath.donatedItems.description)"
    ResourceRequest<DonatedItem>(resourcePath).getAll(tokenNeeded: false) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
          self?.triggerActivityIndicator(false)
          self?.endRefreshing()
        }
      case .success(let donatedItems):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsHistory = [DonatedItem]()
          self.itemsHistory.append(contentsOf: donatedItems)
          self.noHistoryOrFavoriteInfoIfNeeded()
          completionHandler()
          self.triggerActivityIndicator(false)
        }
      }
    }
  }

  //MARK: Fetch all user's received items
  func fetchAllReceivedItemsHistory() {
    guard let userID = UserDefaultsService.shared.userID else { return }
    let resourcePath =
      NetworkPath.donatedItems.description + NetworkPath.isReceivedBy.description + userID
    if !refreshControlTriggered {
      triggerActivityIndicator(true)
    }

    ResourceRequest<DonatedItem>(resourcePath).getAll(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
          self?.triggerActivityIndicator(false)
          self?.endRefreshing()
        }
      case .success(let receivedItems):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsHistory.append(contentsOf: receivedItems)
          self.reloadHistoryItems()
          self.triggerActivityIndicator(false)
          self.noHistoryOrFavoriteInfoIfNeeded()
        }
      }
    }
  }

  //MARK: Fetch all user favorited items
  func fetchFavoritedItems() {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let userID = UserDefaultsService.shared.userID else { return }
    if !refreshControlTriggered {
      triggerActivityIndicator(true)
    }
    let resourcePath =
    "\(NetworkPath.users.description)\(userID)/\(NetworkPath.itemsFavorited.description)"
    
    ResourceRequest<DonatedItem>(resourcePath).getAll(tokenNeeded: false) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
          self?.triggerActivityIndicator(false)
        }
      case .success(let itemsFavorited):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsFavorited = [DonatedItem]()
          self.itemsFavorited.append(contentsOf: itemsFavorited)
          self.reloadFavoritedItems()
          self.triggerActivityIndicator(false)
          self.noHistoryOrFavoriteInfoIfNeeded()
        }
      }
    }
  }

  //MARK: An user delete his favorited item
  func deleteDonatedItemFrom(_ itemsFavorited: DonatedItem) {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let donatedItemID = itemsFavorited.id else { return }
    triggerActivityIndicator(true)
    
    let resourcePath =
      NetworkPath.donatedItems.description + "\(donatedItemID)/" +
        NetworkPath.favoritedByUser.description + UserDefaultsService.shared.userID!
    ResourceRequest<DonatedItem>(resourcePath).delete(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
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

  //MARK: Receiver remove the item from history and unselect it
  func receiverUnselect(_ donatedItem: DonatedItem?) {
    guard let donatedItemID = donatedItem!.id else { return }
    guard var updatedDonatedItem = donatedItem else { return }
    
    updatedDonatedItem.receiverID = StaticLabel.emptyString.description
    updatedDonatedItem.isPicked = false
    triggerActivityIndicator(true)
    
    let resourcePath = NetworkPath.donatedItems.description + "\(donatedItemID)"
    ResourceRequest<DonatedItem>(resourcePath).update(updatedDonatedItem, tokenNeeded: true, { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
          self?.triggerActivityIndicator(false)
        }
      case .success(let pickedUpItem):
        DispatchQueue.main.async { [weak self] in
          updatedDonatedItem = pickedUpItem
          self?.showAlert(title: .successTitle, message: .confirmDonatedItemRemoved)
          self?.triggerActivityIndicator(false)
        }
      }
    })
  }

  //MARK: Donor remove the item from his history and from the database
  func donorDeleteOffTheDatabase(_ donatedItem: DonatedItem) {
    guard let donatedItemID = donatedItem.id else { return }
    triggerActivityIndicator(true)
    
    let resourcePath = NetworkPath.donatedItems.description + "\(donatedItemID)"
    FirebaseStorageHandler.shared.deleteItemImage(of: donatedItem)
    ResourceRequest<DonatedItem>(resourcePath).delete(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .errorTitle, message: .networkRequestError)
          self?.triggerActivityIndicator(false)
        }
      case .success:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .successTitle, message: .donatedItemDeleted)
          self?.triggerActivityIndicator(false)
        }
      }
    }
  }
}

//MARK: - Fetch all user items history
extension HistoryFavoriteVC {
  func fetchItemsHitstory() {
    guard UserDefaultsService.shared.userID != nil else { return }
    fetchAllDonatedItemsHistory(fetchAllReceivedItemsHistory)
  }
}

//MARK: - Populate cells with donators Items from database sorted by date
extension HistoryFavoriteVC {
  func populateItemsHistory(into cell: HistoryTVC, at indexPath: IndexPath) {
    itemsHistory.sort(by: { $0.pickUpDateTime > $1.pickUpDateTime})
    let donorItem = itemsHistory[indexPath.row]

    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    guard let date = dateAndTime?.asString(style: .medium) else { return }
    guard let time = dateAndTime?.asString() else { return }

    cell.topLabel.text = "\(date)  \(StaticItemDetail.at.description) \(time)"
    cell.bottomLabel.text = donorItem.name
    guard donorItem.isPicked else {
      cell.middleLabel.text = StaticLabel.donationNotSelected.description
      return
    }
    cell.middleLabel.text = StaticLabel.donationIsSelected.description
  }
}

//MARK: - Populate cells with favorited Items from database sorted by date
extension HistoryFavoriteVC {
  func populateItemsFavorited(into cell: FavoriteTVC, at indexPath: IndexPath) {
    itemsFavorited.sort(by: { $0.pickUpDateTime > $1.pickUpDateTime})
    let donorItem = itemsFavorited[indexPath.row]

    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    guard let date = dateAndTime?.asString(style: .medium) else { return }
    guard let time = dateAndTime?.asString() else { return }

    cell.topLabel.text = "\(date)  \(StaticItemDetail.at.description) \(time)"
    cell.bottomLabel.text = donorItem.name
    guard donorItem.isPicked else {
      cell.middleLabel.text = StaticLabel.donationNotSelected.description
      return
    }
    cell.middleLabel.text = StaticLabel.donationIsSelected.description
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

//MARK: - Manage deletion action from donor or receveiver in history or favorite side
extension HistoryFavoriteVC {
  func removeUserChosenItem(at indexPath: IndexPath, on tableView: UITableView) {
    if isHistoryButtonClicked {
      if itemsHistory[indexPath.row].receiverID == UserDefaultsService.shared.userID {
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

//MARK: - Refresh control method to reload data
extension HistoryFavoriteVC {
  func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(refreshDonatedItems), for: .valueChanged)
    refreshControl.commonDesign(title: .emptyString)
    HistoryFavoriteTableView.addSubview(refreshControl)
  }

  @objc private func refreshDonatedItems(_ sender: Any) {
    refreshControlTriggered = true
    if isHistoryButtonClicked {
      fetchItemsHitstory()
    }
    else {
      fetchFavoritedItems()
    }
    refreshControlTriggered = false
    endRefreshing()
  }

  func endRefreshing() {
    refreshControl.endRefreshing()
  }
}

//MARK: - Reload data with an animation
extension HistoryFavoriteVC {
  func reloadHistoryItems() {
    HistoryFavoriteTableView.reloadData(
      with: .simple(duration: 0.45, direction: .rotation3D(type: .spiderMan), constantDelay: 0))
  }

  func reloadFavoritedItems() {
    HistoryFavoriteTableView.reloadData(
      with: .simple(duration: 0.45, direction: .rotation3D(type: .captainMarvel), constantDelay: 0))
  }
}

//MARK: - Reset to an empty table view if an user is disconnected
extension HistoryFavoriteVC {
  func emptyTableViewForDisconnectedUser() {
    itemsHistory = [DonatedItem]()
    itemsFavorited = [DonatedItem]()
    HistoryFavoriteTableView.reloadData()
  }
}

//MARK: - Fetch history and favorited items on view did load
extension HistoryFavoriteVC {
  func fetchHistoryAndFavoritedItems() {
    checkIfAnUserIsConnected()
    fetchItemsHitstory()
    fetchFavoritedItems()
  }
}

//MARK: - Show info to a user if he has no history or no favorite
extension HistoryFavoriteVC {
  func noHistoryOrFavoriteInfoIfNeeded() {
    if isHistoryButtonClicked {
      guard itemsHistory.count == 0 else {
        noHistoryOrFavoriteInfo.text = nil
        return
      }
      noHistoryOrFavoriteInfo.text = StaticLabel.noHistoryInfo.description
    }
    else {
      guard itemsFavorited.count == 0 else {
        noHistoryOrFavoriteInfo.text = nil
        return
      }
      noHistoryOrFavoriteInfo.text = StaticLabel.noFavoriteInfo.description
    }
  }
}
