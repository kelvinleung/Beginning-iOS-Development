//
//  DoubleComponentPickerViewController.swift
//  Pickers
//
//  Created by Kelvin Leung on 21/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController {

    @IBOutlet weak var doublePicker: UIPickerView!
    private let fillingComponent = 0
    private let breadComponent = 1
    private let fillingTypes = ["Ham", "Turkey", "Peanut Butter", "Tuna Salad", "Chicken Salad", "Roast Beef", "Vegemite"]
    private let breadTypes = ["White", "Whole Wheat", "Rye", "Sourdough", "Seven Grain"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let fillingRow = doublePicker.selectedRow(inComponent: fillingComponent)
        let breadRow = doublePicker.selectedRow(inComponent: breadComponent)
        let filling = fillingTypes[fillingRow]
        let bread = breadTypes[breadRow]
        
        let message = "Your \(filling) on \(bread) bread will be right up"
        let alert = UIAlertController(title: "Thank you for your order", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Great", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension DoubleComponentPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == fillingComponent {
            return fillingTypes.count
        } else {
            return breadTypes.count
        }
    }
}

extension DoubleComponentPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == fillingComponent {
            return fillingTypes[row]
        } else {
            return breadTypes[row]
        }
    }
}
