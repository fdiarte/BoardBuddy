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
    
    @IBOutlet weak var moneyRequestTextField: UITextField!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    let singleTap = UITapGestureRecognizer()
    
    var player: Player?
    var players: [Player]?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        singleTap.addTarget(self, action: #selector(dismissKeyboard))
        singleTap.numberOfTapsRequired = 1
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    @objc func keyboardWillShow() {
        view.addGestureRecognizer(singleTap)
        view.frame.origin.y = -150
    }

    @objc func keyboardWillHide() {
        view.removeGestureRecognizer(singleTap)
        view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK: - Methods
    
    @IBAction func requestFundsButtonPressed(_ sender: Any) {
        print("request funds button pressed")
        guard let player = player else { return }
        guard let moneyRequestString = moneyRequestTextField.text else { return }
        guard let moneyRequest = Int(moneyRequestString) else { return }
        guard let players = players else { return }
        var playerReqestingFunds: Player?
        
        for player in players {
            if player.deviceName == UIDevice.current.name {
                playerReqestingFunds = player
            }
        }
        
        guard let playerRequesting = playerReqestingFunds else { return }
        
        let fundsRequst = RequestFundsController.shared.createNewRequestForFunds(playerRequestingFunds: playerRequesting, playerToSend: player, for: moneyRequest)
        MPCManager.shared.sendRequestFunds(request: fundsRequst, to: player)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapGestureTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateViews() {
        guard let player = player else { return }
        guard let image = UIImage(data: player.imageData) else { return }
        nameLabel.text = player.displayName
        moneyLabel.text = "\(player.moneyAmount)"
        boardPieceImageView.image = image
        
        boardPieceImageView.tintColor = Colors.mintCreme
    }
}
