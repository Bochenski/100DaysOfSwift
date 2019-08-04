//
//  Image.swift
//  Challenge04
//
//  Created by David Bochenski on 04/08/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit

class Image: NSObject, Codable {
    var comment: String
    var path: String
    init(comment: String, path: String) {
        self.comment = comment
        self.path = path
    }

}
