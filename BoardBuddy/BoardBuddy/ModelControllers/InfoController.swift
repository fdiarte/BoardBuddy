//
//  InfoController.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/18/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation

class RequestFundsController {
    
    static let shared = RequestFundsController()
    
    func createNewRequestForFunds(from player: Player, for amount: Int) -> RequestFunds {
        let newRequest = RequestFunds(player: player, amount: amount)
        return newRequest
    }
}

class AcceptFundsController {
    
    static let shared = AcceptFundsController()
    
    func createAcceptedFunds(didAccept: Bool, amount: Int, from payer: Player) -> AcceptFunds {
        let newAcceptedFunds = AcceptFunds(didAccept: didAccept, amount: amount, from: payer)
        return newAcceptedFunds
    }
}
