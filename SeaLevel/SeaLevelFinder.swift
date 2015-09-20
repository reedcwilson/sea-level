//
//  SeaLevelFinder.swift
//  SeaLevel
//

import Foundation
import CoreLocation

class SealevelFinder {
    
    let padding = CLLocationDistance(15)
    
    func atSeaLevel(altitude: CLLocationDistance?, verticalAccuracy: CLLocationAccuracy) -> Bool? {
        if verticalAccuracy < 0 {
            return nil
        }

        return altitude <= padding && altitude >= -padding;
    }

}