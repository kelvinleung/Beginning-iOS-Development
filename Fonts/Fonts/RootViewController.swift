//
//  RootViewController.swift
//  Fonts
//
//  Created by Kelvin Leung on 28/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoritesList: FavoritesList!
    private static let familyCell = "FamilyName"
    private static let favoritesCell = "Favorites"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames = UIFont.familyNames.sorted()
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: .headline)
        cellPointSize = preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoritesList
        tableView.estimatedRowHeight = cellPointSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: IndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNames(forFamilyName: familyName).first
            return fontName != nil ? UIFont(name: fontName!, size: cellPointSize) : nil
        } else {
            return nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let listVC = segue.destination as! FontListViewController
        
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            listVC.fontNames = UIFont.fontNames(forFamilyName: familyName).sorted()
            listVC.navigationItem.title = familyName
            listVC.showsFavorites = false
        } else {
            listVC.fontNames = favoritesList.favorites
            listVC.navigationItem.title = "Favorites"
            listVC.showsFavorites = true
        }
    }
    
}

extension RootViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RootViewController.familyCell, for: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: RootViewController.favoritesCell, for: indexPath)
        }
    }
}
