//
//  LobbyTableViewController.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class LobbyTableViewController: UITableViewController, MPCManagerDelegate {
    
    var players = PlayerController.shared.players
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MPCManager.shared.delegate = self     
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MPCManager.shared.currentGamePeers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        cell.textLabel?.text = MPCManager.shared.currentGamePeers[indexPath.row].displayName

        return cell
    }
    
    func playerJoinedSession() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func playerRecieved(from data: Data) {
        guard let decodedPlayer = DataManager.shared.decodePlayer(from: data) else { return }
        players.append(decodedPlayer)
        for player in players {
            print("Player Name: \(player.displayName)")
        }
    }
}
