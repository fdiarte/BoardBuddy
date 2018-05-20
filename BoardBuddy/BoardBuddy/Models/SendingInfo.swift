//
//  SendingInfo.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/16/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation

class SendingInfo: Codable {
    var amountChanged: Int
    
    init(amountChanged: Int) {
        self.amountChanged = amountChanged
    }
}
