//
//  ViewController.swift
//  Project2
//
//  Created by David Bochenski on 04/07/2019.
//  Copyright © 2019 David Bochenski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
   
    var countries = [String]()
    var score = 0
    var highScore = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))

        
        countries += ["estonia", "france", "germany",
                      "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia",
                      "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(scoreTapped))
        
        let defaults = UserDefaults.standard
        highScore = defaults.integer(forKey: "highScore")
        
        scheduleLocal()
        
        askQuestion()
    }
    
    @objc func registerLocal() {
          let center = UNUserNotificationCenter.current()
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
          content.title = "We miss you"
          content.body = "Play the game!"
          content.categoryIdentifier = "alarm"
          content.userInfo = ["customData": "fizzbuzz"]
          content.sound = .default
          
          var dateComponents = DateComponents()
          dateComponents.hour = 10
          dateComponents.minute = 30
          
         // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        for day in 1...7 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400 * Double(day), repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)        }
          

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
                switch response.actionIdentifier {
                case UNNotificationDefaultActionIdentifier:
                    // the user swiped to unlock
                    let ac = UIAlertController(title: "Hey", message: "you're back!", preferredStyle: .alert)
                    let submitAction = UIAlertAction(title: "OK", style: .default)
                     ac.addAction(submitAction)
                    present(ac, animated: true)
                default:
                    break
                }
            }
            
            completionHandler()
        }
    
    @objc func scoreTapped() {
        
        
        let ac = UIAlertController(title: "CurrentScore" , message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        if questionsAsked == 10 {
            var message =  "Your final score is \(score)"
            if score > highScore  {
                highScore = score
                let defaults = UserDefaults.standard
                defaults.set(highScore, forKey: "highScore")
                message = "\(score) is the new high score!"
            }
            let acFinish = UIAlertController(title: "Complete", message: message, preferredStyle: .alert)
            acFinish.addAction(UIAlertAction(title: "End Game", style: .default, handler: nil))
            present(acFinish, animated: true)
            return
        }
        
        questionsAsked += 1
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Find: \(countries[correctAnswer].uppercased()) - Current Score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {

        
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
 
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8  )
        })
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1  )
        })
        
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)

    }
}

