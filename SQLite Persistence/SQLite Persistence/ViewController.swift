//
//  ViewController.swift
//  SQLite Persistence
//
//  Created by Kelvin Leung on 14/10/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        var database: OpaquePointer? = nil
        var result = sqlite3_open(dataFilePath(), &database)
    }
    
    func dataFilePath() -> String {
        return ""
    }
    
}

