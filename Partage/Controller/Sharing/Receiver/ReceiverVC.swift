//
//  ReceiverVC.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import CoreLocation

class ReceiverVC: UIViewController {

  @IBOutlet weak var receiverTableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  var donatedItems = [DonatedItem]()
  var itemsNotPicked = [DonatedItem]()
  var oneDonatedItem: DonatedItem?

  var isFavorited = false

  let refreshControl = UIRefreshControl()
  var refreshControlTriggered = false

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(false, animated: false)
    triggerActivityIndicator(false)
    itemsNotPicked = donatedItems.filter({ $0.isPicked == false })
    fetchDonorsItemsFromDatabase()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(false)
    if self.isMovingFromParent {
      navigationController?.setNavigationBarHidden(true, animated: true)
    }
  }
}

//MARK: - Main setup
extension ReceiverVC {
  //MARK: Developer main design
  func setupMainDesign() {
    setupMainView()
    setupCustomCell()
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
    receiverTableView.delegate = self
    receiverTableView.dataSource = self
  }
}

//MARK: - Design setup
extension ReceiverVC {
  //MARK: Setup navigation controller design
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }

  //MARK: Setup table view design
  func setupTableViewDesign() {
    receiverTableView.setupMainBackgroundColor()
  }

  //MARK: Setup all custom cells
  func setupCustomCell() {
    receiverTableView.setupCustomCell(nibName: .ReceiverTVC, identifier: .ReceiverTVC)
  }

  //MARK: Setup custom cell heigt for iPad
  func setupCellHeightForIPad() {
    if UIDevice.current.userInterfaceIdiom == .pad {
      receiverTableView.rowHeight = 360
    }
  }
}

//MARK: - Setup ReceiverVC table view and its action when a cell is clicked
extension ReceiverVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsNotPicked.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: CustomCell.ReceiverTVC.rawValue, for: indexPath) as! ReceiverTVC
    populateDonatorsItems(into: cell, at: indexPath)
    checkIfAnUserFavoritedItem(into: cell, at: indexPath)
    updapteFavoritedButton(in: cell)
    FirebaseStorageHandler.shared.downloadItemImage(of: itemsNotPicked[indexPath.row], into: cell.itemImage)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    setupDonatorItemFromSelectedCell(at: indexPath)
    performSegue(withIdentifier: Segue.goToItemSelectedVC.rawValue, sender: oneDonatedItem)
  }
}

//MARK: - Setup one donator item from selected cell to send to ItemSelectedVC
extension ReceiverVC {
  func setupDonatorItemFromSelectedCell(at indexPath: IndexPath) {
    oneDonatedItem = DonatedItem(
      isPicked: itemsNotPicked[indexPath.row].isPicked,
      selectedType: itemsNotPicked[indexPath.row].selectedType,
      name: itemsNotPicked[indexPath.row].name,
      pickUpDateTime: itemsNotPicked[indexPath.row].pickUpDateTime,
      description: itemsNotPicked[indexPath.row].description,
      latitude: itemsNotPicked[indexPath.row].latitude,
      longitude: itemsNotPicked[indexPath.row].longitude
    )
    oneDonatedItem?.id = itemsNotPicked[indexPath.row].id
  }
}

//MARK: - Populate cells with donators Items from database that is not picked by receiver
extension ReceiverVC {
  func populateDonatorsItems(into cell: ReceiverTVC, at indexPath: IndexPath) {
    let userLocation = LocationHandler.shared.userLocation()
    itemsNotPicked.sort(by: userLocation)

    let donorItem = itemsNotPicked[indexPath.row]

    populateDateAndTime(in: cell, with: donorItem.pickUpDateTime)

    let itemLocation = CLLocation(latitude: donorItem.latitude, longitude: donorItem.longitude)
    var distance = userLocation.distance(from: itemLocation)

    cell.itemTypeLabel.text = donorItem.selectedType
    cell.itemNameLabel.text = donorItem.name
    cell.showLocationSurrounding(latitude: donorItem.latitude, longitude: donorItem.longitude)

    if distance > 1000 {
      distance /= 1000
      cell.itemDistanceLabel.text =
      "\(String(format: "%.2f", distance)) \(StaticItemDetail.distanceInKm.description)"
    }
    else {
      cell.itemDistanceLabel.text =
      "\(String(format: "%.0f", distance)) \(StaticItemDetail.distanceInM.description)"
    }
  }
}

//MARK: - To populate date and time in cell
extension ReceiverVC {
  func populateDateAndTime(in cell: ReceiverTVC, with isoDateString: String) {
    let trimmedIsoString = isoDateString.replacingOccurrences(
      of: StaticLabel.dateOccurence.description,
      with: StaticLabel.emptyString.description, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    let date = dateAndTime?.asString(style: .short)
    let time = dateAndTime?.asString()

    cell.dateLabel.text = date
    cell.timeLabel.text = time
  }
}

//MARK: - Activity Indicator action and setup
extension ReceiverVC {
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

//MARK: - Prepare for segue
extension ReceiverVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? ItemSelectedVC else { return }
    destinationVC.donatedItem = oneDonatedItem
  }
}

//MARK: - API calls
extension ReceiverVC {
  //MARK: Check if an user favorited the donated item
  func checkIfAnUserFavoritedItem(into cell: ReceiverTVC, at indexPath: IndexPath) {
    guard UserDefaultsService.shared.userID != nil else { return }
    guard let donatedItemID = itemsNotPicked[indexPath.row].id else { return }

    let resourcePath =
      NetworkPath.donatedItems.description + "\(donatedItemID)/" + NetworkPath.favoritedByUser.description
    ResourceRequest<User>(resourcePath).getAll(tokenNeeded: true) { (result) in
      switch result {
      case .failure:
        break
      case .success(let users):
        DispatchQueue.main.async {
          for user in users {
            if user.id?.uuidString == UserDefaultsService.shared.userID {
              cell.favoriteButton.setImage(UIImage(named: ImageName.fullHeart.rawValue), for: .normal)
            }
          }
        }
      }
    }
  }

//MARK: Fetch all donated items from database
  func fetchDonorsItemsFromDatabase() {
    if !refreshControlTriggered {
      triggerActivityIndicator(true)
    }
    let resourcePath = NetworkPath.donatedItems.description
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
          self.donatedItems = [DonatedItem]()
          self.triggerActivityIndicator(false)
          self.itemsNotPicked = donatedItems.filter({ $0.isPicked == false })
          self.receiverTableView.reloadData()
          self.endRefreshing()
        }
      }
    }
  }
}

//MARK: - Refresh control method to reload data
extension ReceiverVC {
  func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(refreshDonatedItems), for: .valueChanged)
    refreshControl.commonDesign(title: .emptyString)
    receiverTableView.addSubview(refreshControl)
  }

  @objc private func refreshDonatedItems(_ sender: Any) {
    refreshControlTriggered = true
    fetchDonorsItemsFromDatabase()
  }

  func endRefreshing() {
    refreshControl.endRefreshing()
    refreshControlTriggered = false
  }
}

//MARK: - Update cell favorited button
extension ReceiverVC {
  func updapteFavoritedButton(in cell: ReceiverTVC) {
    if isFavorited {
      cell.favoriteButton.setImage(UIImage(named: ImageName.fullHeart.rawValue), for: .normal)
    }
    else {
      cell.favoriteButton.setImage(UIImage(named: ImageName.emptyHeart.rawValue), for: .normal)
    }
  }
}
