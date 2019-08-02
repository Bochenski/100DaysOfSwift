//
//  Person.swift
//  Project12a
//
//  Created by David Bochenski on 28/07/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
