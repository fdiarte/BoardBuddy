//
//  PlayerCollectionViewCell.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    var player: Player? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var playerAmountLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    func updateViews() {
        backgroundColor = Colors.green
        
        
    }
    
}
