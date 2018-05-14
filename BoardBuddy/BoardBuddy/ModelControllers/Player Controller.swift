//
//  PlayerController.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class PlayerController {
    static let shared = PlayerController()
    
    var players: [Player] = []
    
    func createNewPlayerWithName(displayName: String, imageData: Data, moneyAmount: Int, isHost: Bool) {
        let player = Player(displayName: displayName, imageData: imageData, moneyAmount: moneyAmount, isHost: isHost)
        players.append(player)
    }
    
    func requestAmount(amount: Int, from player: Player, requester: Player) {
        
    }

    func requestAmount(amount: Int, from banker: Banker, for player: Player) {
        
    }
    
    func payBanker(banker: Banker, amount: Int, player: Player) {
        
    }
}
