//
//  ViewController.swift
//  SeaLevel
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, SettingsViewDelegate {
    
    let manager = CLLocationManager()
    var currentLocation: CLLocation? = nil

    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var detectSeaLevelButton: UIButton!
    
    @IBAction func detectSeaLevelExecute(sender: UIButton) {
        let settingsUrl: NSURL? = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(settingsUrl!)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is SettingsViewController {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            let settingsViewController = segue.destinationViewController as! SettingsViewController
            blurEffectView.frame = settingsViewController.view.bounds;
            settingsViewController.delegate = self
            settingsViewController.view.insertSubview(blurEffectView, atIndex:0)
        }
    }
    
    func settingsViewDidFinish(controller: SettingsViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        detectSeaLevel(currentLocation)
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
        loadingSpinner.stopAnimating()
        //if let location = locations.last {
            let coord = CLLocationCoordinate2D(latitude: 34.0219, longitude: 118.4814)
            let location = CLLocation.init(coordinate: coord, altitude: -20, horizontalAccuracy: 4, verticalAccuracy: 4, timestamp: NSDate())
            //let location = CLLocation.init(coordinate: coord, altitude: 18, horizontalAccuracy: 4, verticalAccuracy: 4, timestamp: NSDate())
            currentLocation = location
            detectSeaLevel(location)
        //}
    }
    
    func detectSeaLevel(location: CLLocation?) {
        if location != nil {
            let seaLevelFinder = SealevelFinder()
            if let result = seaLevelFinder.atSeaLevel(location!.altitude, verticalAccuracy: location!.verticalAccuracy, padding: CLLocationDistance(PaddingManager.instance.getDefaultPaddingAsInt())) {
                if result == AtSeaLevel.Yes {
                    displayYes()
                }
                else if result == AtSeaLevel.Above {
                    displayAbove()
                }
                else {
                    displayBelow()
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
        UIImageView()
        view?.backgroundColor = UIColor(patternImage: UIImage(named: "Ocean.png")!)
    }
    
    func displayAbove() {
        resetLabels()
        noLabel.hidden = false
        view?.backgroundColor = UIColor(patternImage: UIImage(named: "Mountains.png")!)
    }
    
    func displayBelow() {
        resetLabels()
        noLabel.hidden = false
        view?.backgroundColor = UIColor(patternImage: UIImage(named: "Underwater")!)
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

