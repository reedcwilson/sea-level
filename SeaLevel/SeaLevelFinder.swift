//
//  SeaLevelFinder.swift
//  SeaLevel
//

import Foundation
import CoreLocation

enum AtSeaLevel {
    case Yes
    case Above
    case Below
}

class SealevelFinder {
    
    func atSeaLevel(altitude: CLLocationDistance?, verticalAccuracy: CLLocationAccuracy, padding: CLLocationDistance) -> AtSeaLevel? {
        if verticalAccuracy < 0 {
            return nil
        }
        if altitude <= padding && altitude >= -padding {
            return AtSeaLevel.Yes
        }
        else if altitude > padding {
            return AtSeaLevel.Above
        }
        else {
            return AtSeaLevel.Below
        }
    }

}