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
    let paddingManager = PaddingManager()

    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var detectSeaLevelButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBAction func detectSeaLevelExecute(sender: UIButton) {
        let settingsUrl: NSURL? = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(settingsUrl!)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is SettingsViewController {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            let settingsViewController = segue.destinationViewController as! SettingsViewController
            settingsViewController.delegate = self
            blurEffectView.frame = settingsViewController.view.bounds;
            settingsViewController.view.insertSubview(blurEffectView, atIndex:0)
        }
    }
    
    func settingsViewDidFinish(controller: SettingsViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        detectSeaLevel(currentLocation)
    }
    
    func getPaddingManager() -> PaddingManager {
        return self.paddingManager
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
//        locationManager(manager, didUpdateLocations: [])
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
        if let location = locations.last {
//            let coord = CLLocationCoordinate2D(latitude: 34.0219, longitude: 118.4814)
//            let location = CLLocation.init(coordinate: coord, altitude: -20, horizontalAccuracy: 4, verticalAccuracy: 4, timestamp: NSDate())
//            let location = CLLocation.init(coordinate: coord, altitude: 18, horizontalAccuracy: 4, verticalAccuracy: 4, timestamp: NSDate())
            currentLocation = location
            detectSeaLevel(location)
        }
    }
    
    func detectSeaLevel(location: CLLocation?) {
        if location != nil {
            let seaLevelFinder = SealevelFinder()
            if let result = seaLevelFinder.atSeaLevel(location!.altitude, verticalAccuracy: location!.verticalAccuracy, padding: CLLocationDistance(paddingManager.getDefaultPaddingAsInt())) {
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
        resetView()
        yesLabel.hidden = false
        backgroundImageView.image = UIImage(named: "Ocean.png")
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.hidden = false
    }
    
    func displayAbove() {
        resetView()
        noLabel.hidden = false
        backgroundImageView.image = UIImage(named: "Mountains.png")
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.hidden = false
    }
    
    func displayBelow() {
        resetView()
        noLabel.hidden = false
        backgroundImageView.image = UIImage(named: "Underwater.png")
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.hidden = false
    }
    
    func displayQuestion() {
        resetView()
        questionLabel.hidden = false
    }
    
    func displayPermissionButton() {
        resetView()
        detectSeaLevelButton.hidden = false
    }
    
    func resetView() {
        loadingSpinner.hidden = true
        yesLabel.hidden = true
        noLabel.hidden = true
        questionLabel.hidden = true
        detectSeaLevelButton.hidden = true
        backgroundImageView.hidden = true
    }
    
}

