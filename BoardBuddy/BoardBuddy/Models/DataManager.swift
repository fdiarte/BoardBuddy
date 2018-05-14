//
//  DataManager.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    func encodePlayer(player: Player) {
        
    }
    
    func encodeMoney(money: Money) {
        
    }
    
    func decodePlayer(from data: Data) -> Player? {
        do {
            let player = try JSONDecoder().decode(Player.self, from: data)
            return player
        } catch {
            print("Error decoding player")
        }
        return nil
    }
    
}
