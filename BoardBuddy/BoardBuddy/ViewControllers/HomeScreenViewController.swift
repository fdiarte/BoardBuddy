//
//  HomeScreenViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        updateViews()
    }
    
    func updateViews() {
//        guard let user = user else {return}   when we find out who the phones user is
        sessionNameLabel.text = "this session"
        boardPieceImageView.image = #imageLiteral(resourceName: "Car")
        nameLabel.text = "MonopolyLord1241"
        totalAmountLabel.text = "$2300.0"
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCollectionViewCell
//        let player = PlayerController.shared.players[indexPath.row]
        cell?.playerNameLabel.text = "MonopolyKing"
        cell?.playerAmountLabel.text = "$1500.00"
        cell?.boardPieceImageView.image = #imageLiteral(resourceName: "Car")
//        cell?.player = player
        return cell ?? UICollectionViewCell()
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayerDetailVC" {
            guard let destinationVC = segue.destination as? PlayerDetailViewController,
            let cell = sender as? PlayerCollectionViewCell, 
            let indexpath = collectionView.indexPath(for: cell) else {return}
            let player = PlayerController.shared.players[indexpath.item]
            destinationVC.player = player
        }
    }
}
