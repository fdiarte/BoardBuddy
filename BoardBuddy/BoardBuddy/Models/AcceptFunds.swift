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
    
    init(didAccept: Bool, amount: Int) {
        self.didAccept = didAccept
        self.amount = amount
    }
}
