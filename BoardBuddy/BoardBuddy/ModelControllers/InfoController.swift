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
    
    func createNewRequestForFunds(playerRequestingFunds: Player, playerToSend: Player, for amount: Int) -> RequestFunds {
        let newRequest = RequestFunds(playerRequestingFunds: playerRequestingFunds, playerToSend: playerToSend, amount: amount)
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

class MatchEndedController {
    static let shared = MatchEndedController()
    
    func createMatchEnd() -> MatchEnded {
        let matchEnd = MatchEnded(isMatchCancelled: true)
        return matchEnd
    }
}

class ReadyInfoController {
    static let shared = ReadyInfoController()
    
    func createReadyInfo() -> ReadyInfo {
        let readyInfo = ReadyInfo(isPlayerReady: true)
        return readyInfo
    }
}
