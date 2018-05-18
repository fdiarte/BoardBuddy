//
//  Banker.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class Banker: Codable {
    let name: String
    var startingAmount: Int
    
    init(startingAmount: Int) {
        self.name = "Banker"
        self.startingAmount = startingAmount
    }
}
