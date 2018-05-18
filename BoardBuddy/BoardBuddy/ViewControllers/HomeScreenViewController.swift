//
//  HomeScreenViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PlayerCollectionViewCellDelegate {

    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var players: [Player]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        updateViews()
    }
    
    
    @IBAction func hamburgerButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "RulesPage", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "rules")
        present(view, animated: true, completion: nil)
    }
    
    func updateViews() {
        var bottomPlayer: Player?
        guard let players = players else { return }
        for player in players {
            if player.deviceName == UIDevice.current.name {
                bottomPlayer = player
            }
        }
        
        guard let currentPlayer = bottomPlayer else { return }
        guard let playerImage = UIImage(data: currentPlayer.imageData) else { return }

        sessionNameLabel.text = "Board Buddy"
        boardPieceImageView.image = playerImage
        boardPieceImageView.tintColor = Colors.mintCreme
        
        nameLabel.text = currentPlayer.displayName
        totalAmountLabel.text = "$ \(currentPlayer.moneyAmount)"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let players = players else { return 0 }
        return players.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCollectionViewCell

        guard var cellPlayers = players else { return UICollectionViewCell() }
     
        for player in cellPlayers {
            if player.deviceName == UIDevice.current.name {
                guard let index = cellPlayers.index(of: player) else { return UICollectionViewCell() }
                cellPlayers.remove(at: index)
            }
        }

        let player = cellPlayers[indexPath.row]
        guard let image = UIImage(data: player.imageData) else { return UICollectionViewCell() }
        //this is a test! we dont want to set cell properties here.... pass the player to the cell and let the cell update its own properties
    
        cell?.playerNameLabel.text = player.displayName
        cell?.playerAmountLabel.text = "$ \(player.moneyAmount)"
        cell?.boardPieceImageView.image = image
        cell?.boardPieceImageView.tintColor = Colors.mintCreme
        cell?.player = player
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func userTappedCell(_ sender: PlayerCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: sender) else { return }
        guard var players = players else { return }
        
        for player in players {
            if player.deviceName == UIDevice.current.name {
                guard let index = players.index(of: player) else { return }
                players.remove(at: index)
            }
        }
        
        let player = players[indexPath.row]
        
        performSegue(withIdentifier: "toPlayerDetailVC", sender: player)
    }

     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayerDetailVC" {
            guard let destinationVC = segue.destination as? PlayerDetailViewController else { return }
            destinationVC.player = sender as? Player
            
        } else if segue.identifier == "toBankVC" {
            let bankcVC = BankDetailViewController()

        }
    }
}

extension HomeScreenViewController: MPCManagerDelegate {
    
    func playerJoinedSession() {
    }
    
    func playerRecieved(from data: Data) {
    }
    
    func infoRecieved(from data: Data) {
    }
    
    func playersArrayRecieved(from data: Data) {
        print("Recieved players from home")
    }
}
