//
//  SendingInfo.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/16/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation

class MatchEnded: Codable {
    var isMatchCancelled: Bool
    
    init(isMatchCancelled: Bool) {
        self.isMatchCancelled = isMatchCancelled
    }
}

class ReadyInfo: Codable {
    var isPlayerReady: Bool
    
    init(isPlayerReady: Bool) {
        self.isPlayerReady = isPlayerReady
    }
}
