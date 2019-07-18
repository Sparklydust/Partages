//
//  ReceiverVC.swift
//  Partage
//
//  Created by Roland Lariotte on 10/06/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ReceiverVC: UIViewController {
  
  @IBOutlet weak var receiverTableView: UITableView!
  
  var donorsItems = [DonatedItem]()
  var oneDonorItem: DonatedItem?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
    DispatchQueue.main.async {
      self.receiverTableView.reloadData()
    }
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
    return donorsItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.receiverCellIdentifier.rawValue, for: indexPath) as! ReceiverTVC
    
    populateDonatorsItems(into: cell, at: indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    setupDonatorItemFromSelectedCell(at: indexPath)
    performSegue(withIdentifier: Segue.goesToItemSelectedVC.rawValue, sender: oneDonorItem)
  }
}

//MARK: - Setup one donator item from selected cell to send to ItemSelectedVC
extension ReceiverVC {
  func setupDonatorItemFromSelectedCell(at indexPath: IndexPath) {
    oneDonorItem = DonatedItem(
      selectedType: donorsItems[indexPath.row].selectedType,
      name: donorsItems[indexPath.row].name,
      pickUpDateTime: donorsItems[indexPath.row].pickUpDateTime,
      description: donorsItems[indexPath.row].description,
      latitude: donorsItems[indexPath.row].latitude,
      longitude: donorsItems[indexPath.row].longitude
    )
  }
}

//MARK: - Populate cells with donators Items from database
extension ReceiverVC {
  func populateDonatorsItems(into cell: ReceiverTVC, at indexPath: IndexPath) {
    let donorItem = donorsItems[indexPath.row]
    
    let isoDateString = donorItem.pickUpDateTime
    let trimmedIsoString = isoDateString.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
    let dateAndTime = ISO8601DateFormatter().date(from: trimmedIsoString)
    let date = dateAndTime?.asString(style: .short)
    let time = dateAndTime?.asString()
    
    cell.itemTypeLabel.text = donorItem.selectedType
    cell.itemNameLabel.text = donorItem.name
    cell.dateLabel.text = date
    cell.timeLabel.text = time
    cell.addMeetingPointOnMap(latitude: donorItem.latitude, longitude: donorItem.longitude)
  }
}

//MARK: - Prepare for segue
extension ReceiverVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? ItemSelectedVC else { return }
    destinationVC.donatorItem = oneDonorItem
  }
}
