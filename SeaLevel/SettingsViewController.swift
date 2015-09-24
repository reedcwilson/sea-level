//
//  ViewController.swift
//  SeaLevel
//

import UIKit
import Foundation

protocol SettingsViewDelegate {
    func settingsViewDidFinish(controller: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var paddingTextField: UITextField!
    var delegate: SettingsViewDelegate?
    
    // validate the user's input before allowing them to exit
    @IBAction func doneButtonExecute(sender: AnyObject) {
        let padding = paddingTextField.text
        // if there is no text, the value is not a number or the number isn't between 0 and 100
        if padding == nil || Int(padding!) == nil || Int(padding!) < 0 || Int(padding!) > 100 {
            let alertController = UIAlertController(title: "Invalid padding value", message: "You must enter a value between 0 and 100.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert:UIAlertAction) in self.paddingTextField.text = PaddingManager.instance.getDefaultPadding()}))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        // set the default to the user's value
        else {
            PaddingManager.instance.setDefaultPadding(padding!)
            submitResult()
        }
    }
    
    func submitResult() {
        if let delegate = self.delegate {
            delegate.settingsViewDidFinish(self)
        }
    }
    
    // Clicking away from the keyboard will remove the keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paddingTextField.text = PaddingManager.instance.getDefaultPadding()
    }
}