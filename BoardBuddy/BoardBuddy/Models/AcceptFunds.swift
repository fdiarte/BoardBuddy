//
//  AcceptRequest.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/17/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation

class AcceptFunds: Codable {
    
    let didAccept: Bool
    let amount: Int
    let payer: Player
    
    init(didAccept: Bool, amount: Int, from payer: Player) {
        self.didAccept = didAccept
        self.amount = amount
        self.payer = payer
    }
}
