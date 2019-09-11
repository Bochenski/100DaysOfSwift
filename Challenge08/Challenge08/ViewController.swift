//
//  ViewController.swift
//  Challenge08
//
//  Created by David Bochenski on 11/09/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        })
    }
}

extension Int {
    func times(clos: () -> Void) {
        for _ in 0 ..< self {
            clos()
        }
    }
}

extension Array where Element: Comparable {
  mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        image.layer.backgroundColor = UIColor.red.cgColor
        
        
        5.times { print("Hello!") }
        
        var numbers = [1, 2, 3, 4, 5]
        numbers.remove(item: 3)
        print(numbers)
    }

    @IBAction func bounceButton(_ sender: Any) {
        image.bounceOut(duration: 5)
    }
    
}

