//
//  ViewController.swift
//  Project22
//
//  Created by David Bochenski on 04/09/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconName: UILabel!
    @IBOutlet var proximityCircle: UIView!
    var locationManager: CLLocationManager?
    var foundIt = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
        proximityCircle.layer.cornerRadius = 128
        proximityCircle.layer.zPosition = 1
        beaconName.layer.zPosition = 2
        distanceReading.layer.zPosition = 2

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid2 = UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!
        scanFor(uuid2, 123, 457, "Beacon2")
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        scanFor(uuid, 123, 456, "Beacon1")
    }
    
    func scanFor(_ uuid: UUID, _ major: CLBeaconMajorValue, _ minor: CLBeaconMinorValue, _ id: String) {
        let bc = CLBeaconIdentityConstraint(uuid: uuid, major: major, minor: minor)
        let br = CLBeaconRegion(beaconIdentityConstraint: bc, identifier: id)
        
        locationManager?.startMonitoring(for: br)
    }

    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
         let beaconRegion = region as? CLBeaconRegion
         if state == .inside {
             // Start ranging when inside a region.
             manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
         } else {
             // Stop ranging when not inside a region.
             manager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
         }
     }
    
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                //self.view.backgroundColor = .blue
                self.proximityCircle.layer.backgroundColor = UIColor.blue.cgColor
                self.proximityCircle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.distanceReading.text = "FAR"
            case .near:
                //self.view.backgroundColor = .orange
                self.proximityCircle.layer.backgroundColor = UIColor.orange.cgColor
                self.proximityCircle.transform = CGAffineTransform(scaleX: 1, y:  1)
                self.distanceReading.text = "NEAR"
            case .immediate:
                //self.view.backgroundColor = .red
                self.proximityCircle.layer.backgroundColor = UIColor.red.cgColor
                self.distanceReading.text = "RIGHT HERE"
                self.proximityCircle.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            default:
                //self.view.backgroundColor = .gray
                self.proximityCircle.layer.backgroundColor = UIColor.gray.cgColor
                self.distanceReading.text = "UNKNOWN"
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {

        for beacon in beacons {
            if foundIt == false {
                foundIt = true
                let ac = UIAlertController(title: "Boom", message: "Beacon detected", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                ac.addAction(action)
                present(ac, animated: true)
            }
            
            beaconName.text = "\(beaconConstraint.major ?? 0)-\(beaconConstraint.minor ?? 0)"
           // print("\(beaconConstraint.uuid.uuidString)- \(beaconConstraint.major ?? 0)-\(beaconConstraint.minor ?? 0)")
            update(distance: beacon.proximity)
        }
    }
}

