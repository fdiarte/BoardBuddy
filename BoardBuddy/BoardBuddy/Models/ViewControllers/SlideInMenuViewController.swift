//
//  SlideInMenuViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/17/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
class Setting: NSObject {
    let name: String
    let imageName: String
    let number: Int
    
    init(name: String, imageName: String, number: Int) {
        self.name = name
        self.imageName = imageName
        self.number = number
    }
}

protocol SlideInMenuViewControllerDelegate: class {
    func settingTapped(settingNumber: Int)
}

class SlideInMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var players: [Player]?

    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: SlideInMenuViewControllerDelegate?

    let settings: [Setting] = {
        let rules = Setting(name: "Rules", imageName: "rules", number: 1)
        let leaveMatch = Setting(name: "Leave Match", imageName: "leave", number: 2)
        let cancelMatch = Setting(name: "Cancel Match", imageName: "leave", number: 3)
        return [rules, leaveMatch, cancelMatch]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingCell", for: indexPath) as! SlideMenuCollectionViewCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.05)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.settingTapped(settingNumber: indexPath.row)
        if indexPath.row == 0 {
        } else if indexPath.row == 1 {
            createLeaveMatchAlert()
        } else {
            createEndMatchAlert()
        }
    }
    
    func endMatch() {
        let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(viewController, animated: true, completion: nil)
        
        MPCManager.shared.stopSession()
    }
                                                                   
    func leaveMatch() {
        
        guard var players = players else { return }
        var currentPlayer: Player?
        
        for (index,player) in players.enumerated() {
            if player.deviceName == UIDevice.current.name {
                currentPlayer = player
                players.remove(at: index)
            }
        }
        
        guard let player = currentPlayer else { return }
 
        MPCManager.shared.playerDisconnected(player: player)
        MPCManager.shared.sendPlayers(players: players)
        
        let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func createLeaveMatchAlert() {
        let alert = UIAlertController(title: "Are you sure you want to leave the match?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let leaveMatchAction = UIAlertAction(title: "Leave Match", style: .destructive) { (_) in
            
            // kick player out
            self.leaveMatch()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(leaveMatchAction)
        present(alert, animated: true, completion: nil)
    }
    
    func createEndMatchAlert() {
        let alert = UIAlertController(title: "Are you sure you want to cancel the match?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let leaveMatchAction = UIAlertAction(title: "Cancel Match", style: .destructive) { (_) in
            
            // kick people out
            self.endMatch()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(leaveMatchAction)
        present(alert, animated: true, completion: nil)
    }
}
