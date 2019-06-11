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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
  }
}

//MARK: - Setup developer main design
extension ReceiverVC {
  func setupMainDesign() {
    navigationItem.setupNavBarProfileImage()
    setupCustomCell()
  }
}

//MARK: - Setup all ReceiverVC delegate
extension ReceiverVC {
  func setupAllDelegates() {
    receiverTableView.delegate = self
    receiverTableView.dataSource = self
  }
}

//MARK: - Setup all custom cells
extension ReceiverVC {
  func setupCustomCell() {
    receiverTableView.setupCustomCell(nibName: .receiverCellIdentifier, identifier: .receiverCellIdentifier)
  }
}

//MARK: - Setup ReceiverVC table view
extension ReceiverVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.receiverCellIdentifier.rawValue, for: indexPath) as! ReceiverTVC
    return cell
  }
}

//MARK: - Action when a cell is selected
extension ReceiverVC {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
