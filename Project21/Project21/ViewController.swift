//
//  ViewController.swift
//  Project21
//
//  Created by David Bochenski on 01/09/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//
import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    var delay: Double = 5

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("Yay!")
            } else {
                print("D'oh!")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        
       // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground)
        let later = UNNotificationAction(identifier: "later", title: "Remind me later",
            options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, later], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            delay = 5
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                let ac = UIAlertController(title: "swiper", message: "you swiped", preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "OK", style: .default)
                 ac.addAction(submitAction)
                present(ac, animated: true)
            case "show":
                let ac = UIAlertController(title: "shower", message: "you showed", preferredStyle: .alert)

                let submitAction = UIAlertAction(title: "OK", style: .default)
                 ac.addAction(submitAction)
                present(ac, animated: true)
            case "later":
                delay = 86400
                scheduleLocal()
                let ac = UIAlertController(title: "later", message: "reminder set", preferredStyle: .alert)

                let submitAction = UIAlertAction(title: "OK", style: .default)
                 ac.addAction(submitAction)
                present(ac, animated: true)
            default:
                break
            }
        }
        
        completionHandler()
    }
}

