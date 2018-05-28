//
//  LobbyTableViewController.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class LobbyTableViewController: UITableViewController, MPCManagerDelegate {
    
    @IBOutlet weak var ViewForActivityIndicator: UIView!
    @IBOutlet weak var startGameButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var players = PlayerController.shared.players
    var rowCount: Int = 0
    var decodedPlayers: [Player] = []
    var readyPlayers = 0
    var isReadySignal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MPCManager.shared.delegate = self
        sendPlayerToHost()
        UIApplication.shared.statusBarStyle = .default
        setupCorrectButton()
        checkCorrectNumberOfPlayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MPCManager.shared.delegate = self
        checkCorrectNumberOfPlayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func sendPlayerToHost() {
        guard let player = players.first else { return }
        MPCManager.shared.sendPerson(player: player)
    }
    
    func checkCorrectNumberOfPlayers() {
        print("Players:" ,players.count)
        if players.count >= 2 {
            for _ in players {
                if players.count > 1 {
                    players.removeLast()
                }
            }
            print("Players: \(players.count)")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MPCManager.shared.currentGamePeers.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if rowCount == 0 || indexPath.row == rowCount {
            cell.alpha = 0
            
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
            cell.layer.transform = transform
            
            UIView.animate(withDuration: (1.0)) {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            }
            rowCount += 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? LobbyCell else {return UITableViewCell()}
        
        cell.userNameLabel.text = MPCManager.shared.currentGamePeers[indexPath.row].displayName
        return cell
    }
    
    func checkNumberOfPlayers() {
        
        for player in players {
            if player.isHost == true {
                print(readyPlayers)
                print(players.count)
                if readyPlayers == players.count - 1 {
                    DispatchQueue.main.async {
                        self.startGameButton.isEnabled = true
                        self.activityIndicator.stopAnimating()
                        self.ViewForActivityIndicator.frame.size.height -= 44
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    func playerJoinedSession() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupCorrectButton() {
        guard let currentPlayer = players.first else { return }
        
        if currentPlayer.isHost == true {
            startGameButton.title = "Start Game"
            startGameButton.isEnabled = false
            cancelButton.isEnabled = true
        } else {
            startGameButton.title = "Ready"
            startGameButton.isEnabled = true
            cancelButton.isEnabled = false
        }
    }
    
    func playersArrayRecieved(from data: Data) {
        guard let decondedPlayers = DataManager.shared.decodePlayers(from: data) else { return }
        
        self.players = decondedPlayers
        
       self.performSegue(withIdentifier: "toHomeVC", sender: self.players)
    }
    
    func playerRecieved(from data: Data) {
        guard let decodedPlayer = DataManager.shared.decodePlayer(from: data) else { return }
        if players.last == decodedPlayer {
            print("Same player")
        } else {
            players.append(decodedPlayer)
            for (index,player) in players.enumerated() {
                print("Player at index from Lobby: \(index)", player.displayName)
            }
        }
    }
    
    func requestFundsRecieved(from data: Data) {
    }    
    func acceptedFundsRecieved(from data: Data) {
    }
    func matchEndedRecieved(from data: Data) {
    }
    func sessionNotConnected() {
        let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func readyInfoRecieved(from data: Data) {
        guard let readyInfo = DataManager.shared.decodeReadyInfo(from: data) else { return }
        print(players.count)
        readyPlayers += 1
        checkNumberOfPlayers()
    }
    
    @IBAction func startGameButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let currentPlayer = players.first else { return }
        
        if currentPlayer.isHost == true {
            MPCManager.shared.sendPlayers(players: players)
            self.performSegue(withIdentifier: "toHomeVC", sender: self.players)
        } else {
            // Send host ready info
            let readyInfo = ReadyInfoController.shared.createReadyInfo()
            MPCManager.shared.sendReadyInfo(readyInfo: readyInfo)
            startGameButton.isEnabled = false
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        // Stop advertising
        
        guard let currentPlayer = players.first else { return }
        
        if currentPlayer.isHost == true {
            MPCManager.shared.stopSession()
        } else {
            return
        }
        
        let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? HomeScreenViewController else { return }
        destinationVC.players = sender as? [Player]
    }
}
