//
//  ViewController.swift
//  Persistence
//
//  Created by Kelvin Leung on 10/10/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path)) {
            if let array = NSArray(contentsOf: fileURL) as? [String] {
                for i in 0..<array.count {
                    lineFields[i].text = array[i]
                }
            }
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: .UIApplicationWillResignActive, object: app)
    }
    
    @objc func applicationWillResignActive(notification: NSNotification) {
        let fileURL = dataFileURL()
        let array = (lineFields as NSArray).value(forKey: "text") as! NSArray
        array.write(to: fileURL, atomically: true)
    }
    
    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls.first!.appendingPathComponent("data.plist")
        return url
    }
    
}
