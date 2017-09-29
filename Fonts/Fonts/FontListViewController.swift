//
//  FontListViewController.swift
//  Fonts
//
//  Created by Kelvin Leung on 29/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    
    var fontNames: [String] = []
    var showsFavorites: Bool = false
    private var cellPointSize: CGFloat!
    private static let cellIdentifier = "FontName"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: .headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showsFavorites {
            fontNames = FavoritesList.sharedFavoritesList.favorites
            tableView.reloadData()
        }
    }
    
    func fontForDisplay(atIndexPath indexPath: IndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes" {
            let sizesVC = segue.destination as! FontSizesViewController
            sizesVC.font = font
            sizesVC.navigationItem.title = font.fontName
        } else {
            let infoVC = segue.destination as! FontInfoViewController
            infoVC.font = font
            infoVC.navigationItem.title = font.fontName
            infoVC.favorite = FavoritesList.sharedFavoritesList.favorites.contains(font.fontName)
        }
    }
    
}

extension FontListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontListViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell
    }
}
