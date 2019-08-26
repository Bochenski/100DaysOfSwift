//
//  Country.swift
//  Challenge05
//
//  Created by David Bochenski on 21/08/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var population: Int
    var area: Double?
}
