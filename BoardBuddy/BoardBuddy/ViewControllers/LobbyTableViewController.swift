//
//  LobbyTableViewController.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class LobbyTableViewController: UITableViewController, MPCManagerDelegate {
  
    @IBOutlet weak var startGameButton: UIBarButtonItem!
    
    var players = PlayerController.shared.players

//    var isMatchReadyToStart: Int? {
//        didSet {
//            self.performSegue(withIdentifier: "toHomeVC", sender: self.players)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MPCManager.shared.delegate = self
        
        startGameButton.isEnabled = false
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MPCManager.shared.currentGamePeers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? LobbyCell else {return UITableViewCell()}
        
        cell.userNameLabel.text = MPCManager.shared.currentGamePeers[indexPath.row].displayName
      
        return cell
    }
    
    func checkNumberOfPlayers() {
        if players.count > 1 {
            startGameButton.isEnabled = true
            checkForHost()
        } else {
            startGameButton.isEnabled = false
            checkForHost()
        }
    }
    
    func playerJoinedSession() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func checkForHost() {
        if self.players.first?.isHost == true {
            startGameButton.isEnabled = true
        } else {
            startGameButton.isEnabled = false
        }
    }
    
    func playersArrayRecieved(from data: Data) {
        guard let decondedPlayers = DataManager.shared.decodePlayers(from: data) else { return }
        self.players = decondedPlayers
        
       self.performSegue(withIdentifier: "toHomeVC", sender: self.players)
    }
    
    func playerRecieved(from data: Data) {
        guard let decodedPlayer = DataManager.shared.decodePlayer(from: data) else { return }
        players.append(decodedPlayer)
        for player in players {
            print("Player Name: \(player.displayName)")
            print("Bool: \(player.isHost)")
        }
        checkNumberOfPlayers()
    }
    
    func infoRecieved(from data: Data) {
//        guard let decodedInfo = DataManager.shared.decodeSendingInfo(from: data) else { return }
//        isMatchReadyToStart = decodedInfo.didSendInfo
    }
    
    @IBAction func startGameButtonTapped(_ sender: UIBarButtonItem) {
//        let info = SendingInfo(didSendInfo: 1)
//        MPCManager.shared.sendInfo(info: info)
        MPCManager.shared.sendPlayers(players: players)
        
        self.performSegue(withIdentifier: "toHomeVC", sender: self.players)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? HomeScreenViewController else { return }
        destinationVC.players = sender as? [Player]
    }
}
