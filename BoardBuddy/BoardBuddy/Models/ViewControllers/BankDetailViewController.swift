//
//  BankDetailViewController.swift
//  BoardBuddy
//
//  Created by Hayden Murdock on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
import AudioToolbox

protocol BankDeailDelegate {
    func playerMoneyIncremented(money: Int)
    func playerMoneyDecremented(money: Int)
}

class BankDetailViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var bankerImageView: UIImageView!
    @IBOutlet weak var moneyAmountTextField: UITextField!
    
    static let shared = BankDetailViewController()
    var delegate: BankDeailDelegate?
    var players: [Player]?
    let singleTap = UITapGestureRecognizer()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        singleTap.numberOfTapsRequired = 1
        singleTap.addTarget(self, action: #selector(dismissKeyboard))
        updateViews()
        moneyAmountTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow() {
        view.addGestureRecognizer(singleTap)
        view.frame.origin.y = -315
    }
    
    @objc func keyboardWillHide() {
        view.removeGestureRecognizer(singleTap)
        view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateViews()
    }
    
    @IBAction func requestMoneyButtonPressed(_ sender: Any) {
        print("request funds from bank button pressed")
        guard let moneyRequested = moneyAmountTextField.text, !moneyRequested.isEmpty, let money = Int(moneyRequested) else { return }
        moneyAmountTextField.text = ""
        moneyAmountTextField.resignFirstResponder()
        createWithdrawlAlert(amountToWithdrawl: money)
    }
    
    @IBAction func tapGestureTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func payBankButtonPressed(_ sender: Any) {
        print("pay bank button pressed")
        guard let moneyToPay = moneyAmountTextField.text, !moneyToPay.isEmpty, let money = Int(moneyToPay) else { return }
        payBankerAlert(amountToPay: money)
        moneyAmountTextField.text = ""
        moneyAmountTextField.resignFirstResponder()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func createWithdrawlAlert(amountToWithdrawl: Int) {
        let alert = UIAlertController(title: "Are you sure you want to withdraw $\(amountToWithdrawl) from the bank?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let withdrawlAction = UIAlertAction(title: "Withdrawl", style: .default) { (_) in
            
            guard var players = self.players else { return }
            AudioServicesPlayAlertSound(1520)
            var currentPlayer: Player?
            var currentPlayerIndex: Int?
            
            for (index,player) in players.enumerated() {
                if player.deviceName == UIDevice.current.name {
                    currentPlayer = player
                    currentPlayerIndex = index
                }
            }
            
            let moneyToSend =  amountToWithdrawl
            currentPlayer?.moneyAmount += amountToWithdrawl
            players.remove(at: currentPlayerIndex!)
            players.append(currentPlayer!)
            MPCManager.shared.sendPlayers(players: players)
            
            self.delegate?.playerMoneyIncremented(money: moneyToSend)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(withdrawlAction)
        present(alert, animated: true, completion: nil)
    }
    
    func payBankerAlert(amountToPay: Int) {
        let alert = UIAlertController(title: "Are you sure you want to pay the bank $\(amountToPay)?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let payAction = UIAlertAction(title: "Pay", style: .default) { (_) in
            
            guard var players = self.players else { return }
            AudioServicesPlayAlertSound(1520)
            var currentPlayer: Player?
            var currentPlayerIndex: Int?
            
            for (index,player) in players.enumerated() {
                if player.deviceName == UIDevice.current.name {
                    currentPlayer = player
                    currentPlayerIndex = index
                }
            }
            
            let moneyToSend = amountToPay
            currentPlayer?.moneyAmount -= amountToPay
            players.remove(at: currentPlayerIndex!)
            players.append(currentPlayer!)
            MPCManager.shared.sendPlayers(players: players)
            
            self.delegate?.playerMoneyDecremented(money: moneyToSend)
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(payAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateViews() {
        bankerImageView.image = UIImage(named: "bank")?.withRenderingMode(.alwaysTemplate)
        bankerImageView.tintColor = Colors.mintCreme
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? HomeScreenViewController else { return }
        destinationVC.moneyAmount = sender as? Int
    }
}
