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
  var isHistoryButtonClicked = true
  
  let goToItemDetailsVC = "goToItemDetailsVC"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainDesign()
    setupAllDelegates()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    setupLastUserHistoryOrFavoriteChoice()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    setupLastUserHistoryOrFavoriteChoice()
  }
}

//MARK: - History button action
extension HistoryFavoriteVC {
  @IBAction func historyButton(_ sender: Any) {
    setupHistoryButtonIsSelected()
    showHistoryCustomCell(true)
  }
}

//MARK: - Favorite button action
extension HistoryFavoriteVC {
  @IBAction func favoriteButton(_ sender: Any) {
    setupFavoriteButtonIsSelected()
    showHistoryCustomCell(false)
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
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = UIColor.iceBackground
  }
}

//MARK: - Setup developer main design
extension HistoryFavoriteVC {
  func setupMainDesign() {
    navigationItem.setupNavBarProfileImage()
    setupEditButton()
    setupAllCustomCells()
  }
}

//MARK: - Setup Table View
extension HistoryFavoriteVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if isHistoryButtonClicked {
    let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath) as! HistoryTVC
      
    return cell
    }
    else {
      let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellIdentifier, for: indexPath) as! FavoriteTVC
      
      return cell
    }
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

//MARK: - Setup all delegates
extension HistoryFavoriteVC {
  func setupAllDelegates() {
    HistoryFavoriteTableView.delegate = self
    HistoryFavoriteTableView.dataSource = self
  }
}

//MARK: - Setup all custom cells
extension HistoryFavoriteVC {
  func setupAllCustomCells() {
    HistoryFavoriteTableView.register(
      UINib(nibName: historyCellIdentifier, bundle: nil), forCellReuseIdentifier: historyCellIdentifier)
    HistoryFavoriteTableView.register(
      UINib(nibName: favoriteCellIdentifier, bundle: nil), forCellReuseIdentifier: favoriteCellIdentifier)
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
    HistoryFavoriteTableView.reloadData()
  }
}

//MARK: - Perform history or favorite segue when row is selected
extension HistoryFavoriteVC {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: goToItemDetailsVC, sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == goToItemDetailsVC {
      
    }
  }
}
