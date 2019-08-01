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
  
  var donatedItems = [DonatedItem]()
  var itemsNotPicked = [DonatedItem]()
  var oneDonatedItem: DonatedItem?
  
  let refreshControl = UIRefreshControl()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(false, animated: false)
    itemsNotPicked = donatedItems.filter({ $0.isPicked == false })
    DispatchQueue.main.async {
      self.receiverTableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
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
    setupNavigationController()
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

//MARK: - Setup navigation controller design
extension ReceiverVC {
  func setupNavigationController() {
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - Setup table view design
extension ReceiverVC {
  func setupTableViewDesign() {
    receiverTableView.setupMainBackgroundColor()
  }
}

//MARK: - Setup all custom cells
extension ReceiverVC {
  func setupCustomCell() {
    receiverTableView.setupCustomCell(nibName: .receiverCellIdentifier, identifier: .receiverCellIdentifier)
  }
}

//MARK: - Setup custom cell heigt for iPad
extension ReceiverVC {
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
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.receiverCellIdentifier.rawValue, for: indexPath) as! ReceiverTVC
    populateDonatorsItems(into: cell, at: indexPath)
    checkIfAnUserFavoritedItem(into: cell, at: indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    setupDonatorItemFromSelectedCell(at: indexPath)
    performSegue(withIdentifier: Segue.goesToItemSelectedVC.rawValue, sender: oneDonatedItem)
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
    
    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(of: StaticLabel.dateOccurence.rawValue, with: StaticLabel.emptyString.rawValue, options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    let date = dateAndTime?.asString(style: .short)
    let time = dateAndTime?.asString()
    
    let itemLocation = CLLocation(latitude: donorItem.latitude, longitude: donorItem.longitude)
    var distance = userLocation.distance(from: itemLocation)
    
    cell.itemTypeLabel.text = donorItem.selectedType
    cell.itemNameLabel.text = donorItem.name
    cell.dateLabel.text = date
    cell.timeLabel.text = time
    cell.addMeetingPointOnMap(latitude: donorItem.latitude, longitude: donorItem.longitude)
    
    if distance > 1000 {
      distance /= 1000
      cell.itemDistanceLabel.text = "\(StaticItemDetail.at.rawValue) \(String(format: "%.2f", distance)) \(StaticItemDetail.distanceInKm.rawValue)"
    }
    else {
      cell.itemDistanceLabel.text = "\(StaticItemDetail.at.rawValue) \(String(format: "%.0f", distance)) \(StaticItemDetail.distanceInM.rawValue)"
    }
  }
}

//MARK: - Prepare for segue
extension ReceiverVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? ItemSelectedVC else { return }
    destinationVC.donatedItem = oneDonatedItem
  }
}

//MARK: - Check if an user favorited the donated item
extension ReceiverVC {
  func checkIfAnUserFavoritedItem(into cell: ReceiverTVC, at indexPath: IndexPath) {
    guard UserDefaultsService.userID != nil else { return }
    guard let donatedItemID = donatedItems[indexPath.row].id else { return }
    DonatedItemRequest(donatedItemID: donatedItemID).populateUserThatFavoritedItem { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .networkRequestError)
        }
      case .success(let users):
        DispatchQueue.main.async {
          for user in users {
            guard user.id?.uuidString == UserDefaultsService.userID  else { return }
            cell.favoriteButton.setImage(UIImage(named: ImageName.fullHeart.rawValue), for: .normal)
          }
        }
      }
    }
  }
}

//MARK: - Refresh control method to reload data
extension ReceiverVC {
  func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(refreshDonatedItems), for: .valueChanged)
    refreshControl.commonDesign(title: .downloadingDonatedItems)
    receiverTableView.addSubview(refreshControl)
  }
  
  @objc private func refreshDonatedItems(_ sender: Any) {
    fetchDonorsItemsFromDatabase()
  }
  
  func fetchDonorsItemsFromDatabase() {
    itemsNotPicked = [DonatedItem]()
    ResourceRequest<DonatedItem>(resourcePath: NetworkPath.donatedItems.rawValue).getAll { (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(title: .error, message: .loadItemError)
          self?.endRefreshing()
        }
      case .success(let donatedItems):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.itemsNotPicked = donatedItems
          self.endRefreshing()
        }
      }
    }
  }
  
  func endRefreshing() {
    refreshControl.endRefreshing()
  }
}
