//
//  ViewController.swift
//  State Lab
//
//  Created by Kelvin Leung on 20/10/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let bounds = view.bounds
        let labelFrame = bounds
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Helvetica", size: 70)
        label.text = "Bazinga!"
        label.textAlignment = .center
        label.backgroundColor = .clear
        view.addSubview(label)
        rotateLabelDown()
    }
    
    func rotateLabelDown() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }) { completed in
            self.rotateLabelUp()
        }
    }
    
    func rotateLabelUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: 0)
        }) { completed in
            self.rotateLabelDown()
        }
    }
    
}

