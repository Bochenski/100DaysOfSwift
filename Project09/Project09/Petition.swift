//
//  Petition.swift
//  Project09
//
//  Created by David Bochenski on 18/07/2019.
//  Copyright © 2019 David Bochenski. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
