//
//  RequestFunds.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/17/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation

class RequestFunds: Codable {
    
    let amount: Int
    let playerRequestingFunds: Player
    let playerToSend: Player
    
    init(playerRequestingFunds: Player, playerToSend: Player, amount: Int) {
        self.playerToSend = playerToSend
        self.playerRequestingFunds = playerRequestingFunds
        self.amount = amount
    }
}
