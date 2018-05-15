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

    var player: Player? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateViews()
    }
    
    //MARK: - Methods
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func requestFundsButtonPressed(_ sender: Any) {
        print("request funds button pressed")
        
    }
    
    
    func updateViews() {
        guard let player = player else {return}
        let image = UIImage(data: player.imageData)
        nameLabel.text = player.displayName
        moneyLabel.text = "\(player.moneyAmount)"
        boardPieceImageView.image = image
    }
}
