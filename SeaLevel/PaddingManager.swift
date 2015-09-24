//
//  PaddingManager.swift
//  SeaLevel
//

import Foundation

class PaddingManager {
    
    static let instance = PaddingManager()
    
    func getDefaultPadding() -> String {
        let standardPadding = "15"
        let defaults = NSUserDefaults.standardUserDefaults()
        if let paddingValue = defaults.valueForKey("paddingValue") as? String {
            return paddingValue
        }
        else {
            defaults.setValue(standardPadding, forKey: "paddingValue")
            defaults.synchronize()
            return standardPadding
        }
    }
    
    func setDefaultPadding(padding:String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(padding, forKey: "paddingValue")
    }
    
    func getDefaultPaddingAsInt() -> Int {
        return Int(getDefaultPadding())!
    }
}