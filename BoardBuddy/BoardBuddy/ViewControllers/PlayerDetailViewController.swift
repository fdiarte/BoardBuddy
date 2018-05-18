//
//  PlayerDetailViewController.swift
//  BoardBuddy
//
//  Created by Hayden Murdock on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet weak var colorLabelOne: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    
    var player: Player?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateViews()
    }
    
    //MARK: - Methods
    
    @IBAction func requestFundsButtonPressed(_ sender: Any) {
        print("request funds button pressed")
        guard let player = player else { return }
        
        let fundsRequst = RequestFundsController.shared.createNewRequestForFunds(from: player, for: 100)
        MPCManager.shared.sendRequestFunds(request: fundsRequst, to: player)
    }
    
    @IBAction func tapGestureTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateViews() {
        guard let player = player else { return }
        guard let image = UIImage(data: player.imageData) else { return }
        nameLabel.text = player.displayName
        moneyLabel.text = "\(player.moneyAmount)"
        boardPieceImageView.image = image
        
        boardPieceImageView.tintColor = Colors.mintCreme
    }
}
