//
//  DependentComponentPickerViewController.swift
//  Pickers
//
//  Created by Kelvin Leung on 21/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController {
    
    @IBOutlet weak var dependentPicker: UIPickerView!
    private let stateComponent = 0
    private let zipComponent = 1
    private var stateZips: [String: [String]]!
    private var states: [String]!
    private var zips: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle.main
        /*
         Click project
         Click target
         Select Build Phases
         Expand Copy Bundle Resources
         Click '+' and select the plist file.
        */
        let plistURL = bundle.url(forResource: "statedictionary", withExtension: "plist")
        stateZips = NSDictionary.init(contentsOf: plistURL!) as! [String: [String]]
        let allStates = stateZips.keys
        states = allStates.sorted()
        let selectedState = states[0]
        zips = stateZips[selectedState]
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let stateRow = dependentPicker.selectedRow(inComponent: stateComponent)
        let zipRow = dependentPicker.selectedRow(inComponent: zipComponent)
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "You selected zip code \(zip)"
        let message = "\(zip) is in \(state)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension DependentComponentPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == stateComponent {
            return states.count
        } else {
            return zips.count
        }
    }
}

extension DependentComponentPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == stateComponent {
            return states[row]
        } else {
            return zips[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == stateComponent {
            let selectedState = states[row]
            zips = stateZips[selectedState]
            dependentPicker.reloadComponent(zipComponent)
            dependentPicker.selectRow(0, inComponent: zipComponent, animated: true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.width
        if component == stateComponent {
            return 2 * pickerWidth / 3
        } else {
            return pickerWidth / 3
        }
    }
}
