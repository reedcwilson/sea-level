//
//  SeaLevelFinder.swift
//  SeaLevel
//

import Foundation
import CoreLocation

class SealevelFinder {
    
    let padding = CLLocationDistance(15)
    
    func atSeaLevel(altitude: CLLocationDistance?, verticalAccuracy: CLLocationAccuracy) -> Bool? {
        var result: Bool? = nil
        if verticalAccuracy > -1 {
            if altitude <= padding && altitude >= -padding {
                result = true
            }
            else {
                result = false
            }
        }
        return result
    }

}