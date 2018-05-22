//
//  PlayerCollectionViewCell.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

protocol PlayerCollectionViewCellDelegate: class {
    func userTappedCell(_ sender: PlayerCollectionViewCell)
}


class PlayerCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: PlayerCollectionViewCellDelegate?
    
    var player: Player? {
        didSet {
            updateViews()
            let tap = UITapGestureRecognizer(target: self, action: #selector(userTappedCell))
            tap.delegate = self as? UIGestureRecognizerDelegate
            addGestureRecognizer(tap)
        }
    }
    
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var playerAmountLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    func updateViews() {
        backgroundColor = Colors.green
    }
    
    @objc func userTappedCell() {
        delegate?.userTappedCell(self)
    }
}
