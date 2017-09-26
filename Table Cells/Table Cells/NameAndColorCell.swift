//
//  NameAndColorCell.swift
//  Table Cells
//
//  Created by Kelvin Leung on 24/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class NameAndColorCell: UITableViewCell {
    
    var name: String = "" {
        didSet {
            if (name != oldValue) {
                nameLabel.text = name
            }
        }
    }
    var color: String = "" {
        didSet {
            if (color != oldValue) {
                colorLabel.text = color
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!

}
