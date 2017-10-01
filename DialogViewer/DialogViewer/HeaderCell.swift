//
//  HeaderCell.swift
//  DialogViewer
//
//  Created by Kelvin Leung on 30/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class HeaderCell: ContentCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.8, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func defaultFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .headline)
    }
    
}
