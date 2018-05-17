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
    
    init(amount: Int) {
       self.amount = amount
    }
}
