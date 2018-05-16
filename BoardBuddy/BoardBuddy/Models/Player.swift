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
    let deviceName: String
    
    init(displayName: String, imageData: Data, isHost: Bool) {
        self.displayName = displayName
        self.moneyAmount = 1500
        self.isHost = isHost
        self.imageData = imageData
        self.deviceName = UIDevice.current.name
    }
}

