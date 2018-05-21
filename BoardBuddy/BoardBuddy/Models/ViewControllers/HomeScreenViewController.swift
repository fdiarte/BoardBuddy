//
//  HomeScreenViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PlayerCollectionViewCellDelegate, SlideInMenuViewControllerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var playerMoneyLabel: AnimatedLabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var blackView: UIView!
    

    var players: [Player]?
    var moneyAmount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContainerView()
        updateViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        MPCManager.shared.delegate = self
    }
    
    func updateContainerView() {
    
        blackView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        blackView.alpha = 0
        containerView.frame = CGRect(x: 0, y: -(view.frame.height), width: view.frame.width, height: view.frame.height * 0.35)
        containerView.alpha = 0
    }
    
    @IBAction func hamburgerButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.blackView.alpha = 1
            self.containerView.alpha = 2
            self.containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.35)
        }) { (success) in
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.blackView.alpha = 0
            self.containerView.frame = CGRect(x: 0, y: -(self.view.frame.height), width: self.view.frame.width, height: self.view.frame.height * 0.35)
            self.containerView.alpha = 0
        }) { (success) in
        }
    }
    
    func settingTapped(settingNumber: Int) {
        dismissView(self)
        if settingNumber == 0 {
            let rulesPage = RulesPageTableViewController()
            let navController = UINavigationController(rootViewController: rulesPage)
            self.present(navController, animated: true, completion: nil)
        } else if settingNumber == 1 {
            //leave match
        } else if settingNumber == 2 {
            //cancel match
        }
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
        playerMoneyLabel.text = "$ \(currentPlayer.moneyAmount)"
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
        } else if segue.identifier == "ToSlideInMenuVC" {
            let destinationVC = segue.destination as? SlideInMenuViewController
            destinationVC?.delegate = self
            destinationVC?.players = self.players

        } else if segue.identifier == "toBankDetailVC" {
            let destinationVC = segue.destination as? BankDetailViewController
            destinationVC?.players = sender as? [Player]
            destinationVC?.delegate = self
        }
    }
    
    @IBAction func userTappedBankButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toBankDetailVC", sender: self.players)
        let presentedVC = BankDetailViewController()
        presentedVC.delegate = self
    }
    
}

extension HomeScreenViewController: MPCManagerDelegate, BankDeailDelegate {

    func playerMoneyDecremented(money: Int) {
        guard let players = players else { return }
        var previousMoney = 0
        var currentMoney = 0
        
        for player in players {
            if player.deviceName == UIDevice.current.name {
                previousMoney = player.moneyAmount + money
                currentMoney = player.moneyAmount
            }
        }
        
        playerMoneyLabel.count(from: Float(previousMoney), to: Float(currentMoney))
    }
    
    func playerMoneyIncremented(money: Int) {
        guard let players = players else { return }
        var previousMoney = 0
        var currentMoney = 0
        
        for player in players {
            if player.deviceName == UIDevice.current.name {
                previousMoney = player.moneyAmount - money
                currentMoney = player.moneyAmount
            }
        }
        
        playerMoneyLabel.count(from: Float(previousMoney), to: Float(currentMoney))
    }
    
    func requestFundsRecieved(from data: Data) {
        guard let fundsRequest = DataManager.shared.decodeRequest(from: data) else { return }
        let requester = fundsRequest.player
        let amountRequesting = fundsRequest.amount
        
        createRequestFundsAlert(requester: requester, amount: amountRequesting, payer: requester)
    }
    
    func acceptedFundsRecieved(from data: Data) {
        guard let acceptedFunds = DataManager.shared.decodeAcceptFunds(from: data) else { return }
        
        if acceptedFunds.didAccept == true {
            let amountRecieved = acceptedFunds.amount
            let payer = acceptedFunds.payer
            
            guard var players = self.players else { return }
            guard let index = players.index(of: payer) else { return }
            players.remove(at: index)
            payer.moneyAmount -= amountRecieved
            players.append(payer)
            
            for player in players {
                if player.deviceName == UIDevice.current.name {
                    let previousAmount = player.moneyAmount
                    let newAmount = player.moneyAmount + amountRecieved
                    player.moneyAmount += amountRecieved
                    DispatchQueue.main.async {
                        MPCManager.shared.sendPlayers(players: players)
                        self.playerMoneyLabel.count(from: Float(previousAmount), to: Float(newAmount))
                    }
                }
            }
        }
    }
    
    func matchEndedRecieved(from data: Data) {
        guard let matchEnded = DataManager.shared.decodeMatchEnd(from: data) else { return }
        
        print("Match end recieved")
        
        if matchEnded.isMatchCancelled == true {
            let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func sessionNotConnected() {
        MPCManager.shared.currentGamePeers.removeAll()
        
        let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func playerJoinedSession() {
    }
    
    func playerRecieved(from data: Data) {
        guard let playerRecieved = DataManager.shared.decodePlayer(from: data) else { return }
        guard var players = players else { return }
        
        for (index,player) in players.enumerated() {
            if playerRecieved.deviceName == player.deviceName {
                DispatchQueue.main.async {
                    players.remove(at: index)
                    players.insert(playerRecieved, at: index)
                    self.players = players
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func infoRecieved(from data: Data) {
    }
    
    func playersArrayRecieved(from data: Data) {
        print("Recieved players from home")
        guard let decondedPlayers = DataManager.shared.decodePlayers(from: data) else { return }
        guard let players = players else { return }
        
        var oldPlayer: Player?
        var newPlayer: Player?
        
        
        for player in players {
            if player.deviceName == UIDevice.current.name {
                oldPlayer = player
            }
        }
        
        for player in decondedPlayers {
            if player.deviceName == UIDevice.current.name {
                newPlayer = player
                DispatchQueue.main.async {
                    self.playerMoneyLabel.count(from: Float((oldPlayer?.moneyAmount)!), to: Float((newPlayer?.moneyAmount)!))
                    self.players = decondedPlayers
                    self.collectionView.reloadData()
                }
            }
        }
        guard let playerToSend = newPlayer else { return }
        MPCManager.shared.sendPerson(player: playerToSend)
        self.players = decondedPlayers
        
    }
    
    func createRequestFundsAlert(requester: Player, amount: Int, payer: Player) {
        let alert = UIAlertController(title: "\(requester.displayName) is requesting $\(amount) from you", message: nil, preferredStyle: .alert)
        let denyButton = UIAlertAction(title: "Deny", style: .cancel, handler: nil)
        let payButton = UIAlertAction(title: "Pay", style: .default) { (_) in
            // send accepted funds model to player
            
            let acceptedFundsRequest = AcceptFundsController.shared.createAcceptedFunds(didAccept: true, amount: amount, from: payer)
            MPCManager.shared.sendAcceptedFunds(acceptedFunds: acceptedFundsRequest, to: requester)
            
        }
        alert.addAction(denyButton)
        alert.addAction(payButton)
        present(alert, animated: true, completion: nil)
    }
}
