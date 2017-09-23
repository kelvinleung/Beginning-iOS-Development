//
//  SingleComponentPickerViewController.swift
//  Pickers
//
//  Created by Kelvin Leung on 21/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class SingleComponentPickerViewController: UIViewController {

    @IBOutlet weak var singlePicker: UIPickerView!
    private let characterNames = ["Luke", "Leia", "Han", "Chewbacca", "Artoo", "Threepio", "Lando"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let row = singlePicker.selectedRow(inComponent: 0)
        let selected = characterNames[row]
        let title = "You selected \(selected)!"
        let alert = UIAlertController(title: title, message: "Thank you for choosing", preferredStyle: .alert)
        let action = UIAlertAction(title: "You're welcome", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK:-
// MARK: Data Source Methods
extension SingleComponentPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characterNames.count
    }
}

// MARK: Delegate Methods
extension SingleComponentPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characterNames[row]
    }
}
