//
//  Person.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class Player: Equatable, Codable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.displayName == rhs.displayName && lhs.moneyAmount == rhs.moneyAmount && lhs.isHost == rhs.isHost
    }
    
    let displayName: String
    let imageData: Data
    var moneyAmount: Int
    var isHost: Bool
    
    init(displayName: String, imageData: Data, moneyAmount: Int, isHost: Bool) {
        self.displayName = displayName
        self.moneyAmount = moneyAmount
        self.isHost = isHost
        self.imageData = imageData
    }
}

