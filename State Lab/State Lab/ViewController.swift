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
    private var animate = false

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
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(ViewController.applicationWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
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
            if self.animate {
                self.rotateLabelDown()
            }
        }
    }
    
    @objc func applicationWillResignActive() {
        print("VC: \(#function)")
        animate = false
    }
    
    @objc func applicationDidBecomeActive() {
        print("VC: \(#function)")
        animate = true
        rotateLabelDown()
    }
    
}

