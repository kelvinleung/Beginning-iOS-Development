//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by Kelvin Leung on 21/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var images: [UIImage]!
    
    private var winSoundID: SystemSoundID = 0
    private var crunchSoundID: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "crown")!,
            UIImage(named: "cherry")!,
            UIImage(named: "lemon")!,
            UIImage(named: "apple")!
        ]
        
        winLabel.text = " "
        
        arc4random_stir()
    }
    
    @IBAction func spin(_ sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        
        for i in 0..<5 {
            let newVal = Int(arc4random_uniform(UInt32(images.count)))
            if newVal == lastVal {
                numInRow += 1
            } else {
                numInRow = 1
            }
            lastVal = newVal
            picker.selectRow(newVal, inComponent: i, animated: true)
            picker.reloadComponent(i)
            if numInRow >= 3 {
                win = true
            }
        }
        
        if crunchSoundID == 0 {
            let soundURL = Bundle.main.url(forResource: "crunch", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundID)
        }
        AudioServicesPlaySystemSound(crunchSoundID)
        
        if win {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.playWinSound()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showButton()
            }
        }
        
        button.isHidden = true
        winLabel.text = " "
    }
    
    private func showButton() {
        button.isHidden = false
    }
    
    private func playWinSound() {
        // initialized as zero and valid identifiers for loaded sounds are not zero
        if winSoundID == 0 {
            let soundURL = Bundle.main.url(forResource: "win", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = "WINNER!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.showButton()
        }
    }
    
}

extension CustomPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
}

extension CustomPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIImageView(image: images[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
}
