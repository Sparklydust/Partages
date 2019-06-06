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
  
  let historyCellIdentifier = "HistoryTVC"
  let favoriteCellIdentifier = "FavoriteTVC"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    HistoryFavoriteTableView.delegate = self
    HistoryFavoriteTableView.dataSource = self
    HistoryFavoriteTableView.register(UINib(nibName: historyCellIdentifier, bundle: nil), forCellReuseIdentifier: historyCellIdentifier)
    HistoryFavoriteTableView.register(UINib(nibName: favoriteCellIdentifier, bundle: nil), forCellReuseIdentifier: favoriteCellIdentifier)
    
    setupEditButton()
    setupHistoryButtonIsSelected()
    navigationItem.setupNavBarProfileImage()
  }
}

//MARK: - History button action
extension HistoryFavoriteVC {
  @IBAction func historyButton(_ sender: Any) {
    setupHistoryButtonIsSelected()
  }
}

//MARK: - Favorite button action
extension HistoryFavoriteVC {
  @IBAction func favoriteButton(_ sender: Any) {
    setupFavoriteButtonIsSelected()
  }
}

//MARK: - Edit button action
extension HistoryFavoriteVC {
  @IBAction func editButton(_ sender: UIBarButtonItem) {
    UIView.animate(withDuration: 0.3) {
      self.HistoryFavoriteTableView.isEditing = !self.HistoryFavoriteTableView.isEditing
      sender.title = (self.HistoryFavoriteTableView.isEditing) ? "Done" : "Edit"
    }
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}

//MARK: - Setup Table View
extension HistoryFavoriteVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath) as! HistoryTVC
    
    return cell
  }
}

//MARK: - Setup edit button design
extension HistoryFavoriteVC {
  func setupEditButton() {
    editButton.editButtonDesign()
  }
}

//MARK: Setup history button is selected design
extension HistoryFavoriteVC {
  func setupHistoryButtonIsSelected() {
    UIView.animate(withDuration: 0.3) {
      self.historyButton.historyFavoriteSelectedDesign(title: .history, shadowWidth: 0, shadowHeight: 0)
      self.favoriteButton.historyFavoriteUnselectedDesign(title: .favorite, shadowWidth: -3, shadowHeight: 3)
    }
  }
}

//MARK: - Setup favorite button is selected design
extension HistoryFavoriteVC {
  func setupFavoriteButtonIsSelected() {
    UIView.animate(withDuration: 0.3) {
      self.favoriteButton.historyFavoriteSelectedDesign(title: .favorite, shadowWidth: 0, shadowHeight: 0)
      self.historyButton.historyFavoriteUnselectedDesign(title: .history, shadowWidth: 3, shadowHeight: 3)
    }
  }
}
