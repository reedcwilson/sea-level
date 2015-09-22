//
//  ViewController.swift
//  SeaLevel
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    @IBAction func doneButtonExecute(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Clicking away from the keyboard will remove the keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}