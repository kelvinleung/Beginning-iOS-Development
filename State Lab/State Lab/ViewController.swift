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
    private var smiley: UIImage!
    private var smileyView: UIImageView!
    private var index = 0
    private var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        let bounds = view.bounds
        let labelFrame = CGRect(origin: CGPoint(x: bounds.origin.x, y: bounds.midY - 50), size: CGSize(width: bounds.size.width, height: 100))
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Helvetica", size: 70)
        label.text = "Bazinga!"
        label.textAlignment = .center
        label.backgroundColor = .clear
        
        let smileyFrame = CGRect(x: bounds.midX - 42, y: bounds.midY / 2 - 42, width: 84, height: 84)
        smileyView = UIImageView(frame: smileyFrame)
        smileyView.contentMode = .center
        let smileyPath = Bundle.main.path(forResource: "smiley", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
        
        segmentedControl = UISegmentedControl(items: ["One", "Two", "Three", "Four"])
        segmentedControl.frame = CGRect(x: bounds.origin.x + 20, y: 50, width: bounds.size.width - 40, height: 30)
        segmentedControl.addTarget(self, action: #selector(ViewController.selectionChanged(_:)), for: .valueChanged)
        
        index = UserDefaults.standard.integer(forKey: "index")
        segmentedControl.selectedSegmentIndex = index
        
        view.addSubview(label)
        view.addSubview(smileyView)
        view.addSubview(segmentedControl)
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(ViewController.applicationWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
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
    
    @objc func applicationDidEnterBackground() {
        print("VC: \(#function)")
        smiley = nil
        smileyView.image = nil
        UserDefaults.standard.set(index, forKey: "index")
    }
    
    @objc func applicationWillEnterForeground() {
        print("VC: \(#function)")
        let smileyPath = Bundle.main.path(forResource: "smiley", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
    }
    
    @objc func selectionChanged(_ sender: UISegmentedControl) {
        index = segmentedControl.selectedSegmentIndex
    }
    
}

