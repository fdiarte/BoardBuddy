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
        boardPieceImageView.image = UIImage(named: "CannonIcon")?.withRenderingMode(.alwaysTemplate)
        boardPieceImageView.tintColor = Colors.mintCreme
        
        nameLabel.text = "MonopolyLord1241"
        totalAmountLabel.text = "$2300.0"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return PlayerController.shared.players.count
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCollectionViewCell
//        let player = PlayerController.shared.players[indexPath.row]
        
        //this is a test! we dont want to set cell properties here.... pass the player to the cell and let the cell update its own properties
    
        cell?.playerNameLabel.text = "MonopolyKing"
        cell?.playerAmountLabel.text = "$1500.00"
        cell?.boardPieceImageView.image = UIImage(named: "DogIcon")?.withRenderingMode(.alwaysTemplate)
        cell?.boardPieceImageView.tintColor = Colors.mintCreme
//        cell?.player = player
        return cell ?? UICollectionViewCell()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayerDetailVC" {
            guard let destinationVC = segue.destination as? PlayerDetailViewController,
            let cell = sender as? PlayerCollectionViewCell,
            let indexpath = collectionView.indexPath(for: cell) else {return}
//            let player = PlayerController.shared.players[indexpath.item]
//            destinationVC.player = player
        } else if segue.identifier == "toBankVC" {
            let bankcVC = BankDetailViewController()

        }
    }
}
