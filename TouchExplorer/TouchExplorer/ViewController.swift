//
//  ViewController.swift
//  TouchExplorer
//
//  Created by Kelvin Leung on 25/10/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tapsLabel: UILabel!
    @IBOutlet weak var touchesLabel: UILabel!
    @IBOutlet weak var forceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updataLabelsFromTouches(_ touch: UITouch?, allTouches: Set<UITouch>?) {
        let numTaps = touch?.tapCount ?? 0
        let tapsMessage = "\(numTaps) taps detected"
        tapsLabel.text = tapsMessage
        
        let numTouches = allTouches?.count ?? 0
        let touchesMessage = "\(numTouches) touches detected"
        touchesLabel.text = touchesMessage
        
        if traitCollection.forceTouchCapability == .available {
            forceLabel.text = """
            Force: \(touch?.force ?? 0)
            Max force: \(touch?.maximumPossibleForce ?? 0)
            """
        } else {
            forceLabel.text = "3D Touch not availabel"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Began"
        updataLabelsFromTouches(touches.first, allTouches: event?.allTouches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Cancelled"
        updataLabelsFromTouches(touches.first, allTouches: event?.allTouches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Moved"
        updataLabelsFromTouches(touches.first, allTouches: event?.allTouches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Ended"
        updataLabelsFromTouches(touches.first, allTouches: event?.allTouches)
    }
    
}
