//
//  ViewController.swift
//  Project18
//
//  Created by David Bochenski on 25/08/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("I'm inside the viewDidLoad method", terminator: "")
        
        print(1, 2, 3, 4, 5, separator: "-" )
        
        assert(1 == 1, "Math failure'")
        //assert(1 == 2, "Math failure!")
        
        for i in 1...100 {
            print("Got number \(i).")
        }
    }


}

