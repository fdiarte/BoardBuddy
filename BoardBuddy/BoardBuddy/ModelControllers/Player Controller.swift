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
    }
}
