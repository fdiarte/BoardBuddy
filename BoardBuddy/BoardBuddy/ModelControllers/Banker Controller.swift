//
//  Banker Controller.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation

class BankerController {
    static let shared = BankerController()
    
    func createBankerWith(startingAmount: Int) -> Banker {
        return Banker(startingAmount: startingAmount)
    }
    
    func payPlayer(player: Player, amount: Int, from banker: Banker) {
        banker.startingAmount -= amount
        player.moneyAmount += amount
    }
}
