//
//  ViewController.swift
//  SeaLevel
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()

    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var detectSeaLevelButton: UIButton!
    
    @IBAction func detectSeaLevelExecute(sender: UIButton) {
        let settingsUrl: NSURL? = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(settingsUrl!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        // we don't need to be too accurate
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        // update every 500 meters changed
        manager.distanceFilter = CLLocationDistance(500)
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(location: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            location.startUpdatingLocation()
        }
        else if status == CLAuthorizationStatus.Restricted {
            displayQuestion()
        }
        else if status == CLAuthorizationStatus.Denied {
            displayPermissionButton()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
        //let coord = CLLocationCoordinate2D(latitude: 34.0219, longitude: 118.4814)
        //let location = CLLocation.init(coordinate: coord, altitude: 3, horizontalAccuracy: 4, verticalAccuracy: 4, timestamp: NSDate())
        //let location = CLLocation.init(coordinate: coord, altitude: 18, horizontalAccuracy: 4, verticalAccuracy: 4, timestamp: NSDate())
            loadingSpinner.stopAnimating()
            let seaLevelFinder = SealevelFinder()
            if let result = seaLevelFinder.atSeaLevel(location.altitude, verticalAccuracy: location.verticalAccuracy) {
                if result == true {
                    displayYes()
                }
                else {
                    displayNo()
                }
            }
            else {
                displayQuestion()
            }
        }
    }
    
    func displayYes() {
        resetLabels()
        yesLabel.hidden = false
    }
    
    func displayNo() {
        resetLabels()
        noLabel.hidden = false
    }
    
    func displayQuestion() {
        resetLabels()
        questionLabel.hidden = false
    }
    
    func displayPermissionButton() {
        resetLabels()
        detectSeaLevelButton.hidden = false
    }
    
    func resetLabels() {
        loadingSpinner.hidden = true
        yesLabel.hidden = true
        noLabel.hidden = true
        questionLabel.hidden = true
        detectSeaLevelButton.hidden = true
    }
    
}

