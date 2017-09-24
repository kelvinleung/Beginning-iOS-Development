//
//  ViewController.swift
//  Simple Table
//
//  Created by Kelvin Leung on 24/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let dwarves = [
        "Sleepy", "Sneezy", "Bashful", "Happy",
        "Doc", "Grumpy", "Dopey",
        "Thorin", "Dorin", "Nori", "Ori",
        "Balin", "Dwalin", "Fili", "Kili",
        "Oin", "Gloin", "Bifur", "Bofur",
        "Bombur"
    ]
    let simpleTableIdentifier = "SimpleTableIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: simpleTableIdentifier)
        }
        cell?.textLabel?.text = dwarves[indexPath.row]
        return cell!
    }
}
