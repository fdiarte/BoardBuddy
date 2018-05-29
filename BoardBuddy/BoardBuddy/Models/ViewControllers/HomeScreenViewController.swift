//
//  HomeScreenViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
import AudioToolbox

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PlayerCollectionViewCellDelegate, SlideInMenuViewControllerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerMoneyLabel: AnimatedLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var bankButton: UIButton!
    
    var players: [Player]?
    var moneyAmount: Int?
    static let shared = HomeScreenViewController()
    let colorArray: [UIColor] = [Colors.blue,
                                 Colors.brown,
                                 Colors.charcoal,
                                 Colors.green,
                                 Colors.gunMetal,
                                 Colors.lightBlue,
                                 Colors.limeGreen,
                                 Colors.mintCreme]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContainerView()
        updateViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        MPCManager.shared.delegate = self
        bankButton.layer.cornerRadius = 10
        UIApplication.shared.statusBarStyle = .default
        MPCManager.shared.advertiserAssistant.stop()
    }
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
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
        SlideInMenuViewController.shared.players = self.players
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
        
        DispatchQueue.main.async {
            var bottomPlayer: Player?
            guard let players = self.players else { return }
            for player in players {
                if player.deviceName == UIDevice.current.name {
                    bottomPlayer = player
                }
            }
            
            guard let currentPlayer = bottomPlayer else { return }
            guard let playerImage = UIImage(data: currentPlayer.imageData) else { return }
            
            self.sessionNameLabel.text = "Board Buddy"
            self.boardPieceImageView.image = playerImage
            self.boardPieceImageView.tintColor = Colors.mintCreme
            
            self.nameLabel.text = currentPlayer.displayName
            self.playerMoneyLabel.text = "$ \(currentPlayer.moneyAmount)"
            self.bankButton.setTitle("Bank", for: .normal)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let players = players else { return 0 }
        return players.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCollectionViewCell
        cell?.layer.cornerRadius = 20
        guard var cellPlayers = players else { return UICollectionViewCell() }
     
        for player in cellPlayers {
            if player.deviceName == UIDevice.current.name {
                guard let index = cellPlayers.index(of: player) else { return UICollectionViewCell() }
                cellPlayers.remove(at: index)
            }
        }

        let player = cellPlayers[indexPath.row]
        guard let image = UIImage(data: player.imageData) else { return UICollectionViewCell() }
    
        let color = colorArray[indexPath.row]
        cell?.playerNameLabel.text = player.displayName
        cell?.playerAmountLabel.text = "$ \(player.moneyAmount)"
        cell?.boardPieceImageView.image = image
        cell?.boardPieceImageView.tintColor = Colors.mintCreme
        cell?.player = player
        cell?.delegate = self
        cell?.backgroundColor = color
        return cell ?? UICollectionViewCell()
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
            destinationVC.players = self.players
            
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
    
    func playerLeft(from data: Data) {
        guard let playerLeftInfo = DataManager.shared.decodePlayerLeftInfo(from: data), var players = players else { return }
        if playerLeftInfo.didPlayerLeave == true {
            
            print("Player left")
            
            DispatchQueue.main.async {
                let playerWhoLeft = playerLeftInfo.player
                guard let index = players.index(of: playerWhoLeft) else { return }
                players.remove(at: index)
                
                self.players = players
                self.collectionView.reloadData()
                
            }
        }
    }
    
    func readyInfoRecieved(from data: Data) {
    }

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
        let requester = fundsRequest.playerRequestingFunds
        let payer = fundsRequest.playerToSend
        let amountRequesting = fundsRequest.amount
        
        createRequestFundsAlert(requester: requester, amount: amountRequesting, payer: payer)
    }
    
    func acceptedFundsRecieved(from data: Data) {
        guard let acceptedFunds = DataManager.shared.decodeAcceptFunds(from: data) else { return }
        AudioServicesPlayAlertSound(1520)
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
        print("Match Ended Recvieved")
        if matchEnded.isMatchCancelled == true {
            let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
            self.present(viewController, animated: true) {
                for peer in MPCManager.shared.currentGamePeers {
                    if peer != MPCManager.shared.currentGamePeers.first {
                        guard let index = MPCManager.shared.currentGamePeers.index(of: peer) else { return }
                        MPCManager.shared.currentGamePeers.remove(at: index)
                    }
                }
                MPCManager.shared.session.disconnect()
            }
        }
    }
    
    func sessionNotConnected() {
        
    }
    
    func playerJoinedSession() {
    }
    
    func playerRecieved(from data: Data) {
        
        print("GOT SINGLE PLAYER")
        
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
    
    func playersArrayRecieved(from data: Data) {
        
        print("GOT PLAYER ARRAY")
        
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
        DispatchQueue.main.async {
            guard let playerToSend = newPlayer else { return }
            MPCManager.shared.sendPerson(player: playerToSend)
            self.players = decondedPlayers
            self.collectionView.reloadData()
            
        }
    }
    
    func createRequestFundsAlert(requester: Player, amount: Int, payer: Player) {
        AudioServicesPlayAlertSound(1520)
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
