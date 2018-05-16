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
    
    func createNewPlayerWithName(displayName: String, image: UIImage, isHost: Bool) {
        
        let imageData = DataManager.shared.encodeImage(from: image)
        guard let data = imageData else { return }
        let newPlayer = Player(displayName: displayName, imageData: data, isHost: isHost)
        players.append(newPlayer)
        
        print("Player created")
    }
    
    
    
//    func requestAmount(amount: Int, from player: Player, requester: Player) {
//
//    }
//
//    func requestAmount(amount: Int, from banker: Banker, for player: Player) {
//
//    }
//
//    func payBanker(banker: Banker, amount: Int, player: Player) {
//
//    }
}
