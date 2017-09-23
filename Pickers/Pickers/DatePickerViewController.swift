//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by Kelvin Leung on 21/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = Date()
        datePicker.setDate(date, animated: true)
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let date = datePicker.date
        let message = "Date and time you selected is \(date)"
        let alert = UIAlertController(title: "Date and Time Selected", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "That's so true!", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
