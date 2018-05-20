//
//  BankDetailViewController.swift
//  BoardBuddy
//
//  Created by Hayden Murdock on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class BankDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var bankerImageView: UIImageView!
    @IBOutlet weak var moneyAmountTextField: UITextField!
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateViews()
    }
    
    @IBAction func requestMoneyButtonPressed(_ sender: Any) {
        print("request funds from bank button pressed")
        guard let moneyRequested = moneyAmountTextField.text, !moneyRequested.isEmpty, let money = Int(moneyRequested) else { return }
        
        createWithdrawlAlert(amountToWithdrawl: money)
    }
    
    @IBAction func tapGestureTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func payBankButtonPressed(_ sender: Any) {
        print("pay bank button pressed")
        guard let moneyToPay = moneyAmountTextField.text, !moneyToPay.isEmpty, let money = Int(moneyToPay) else { return }
        payBankerAlert(amountToPay: money)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func createWithdrawlAlert(amountToWithdrawl: Int) {
        let alert = UIAlertController(title: "Are you sure you want to withdrawl $\(amountToWithdrawl) from the bank?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let withdrawlAction = UIAlertAction(title: "Withdrawl", style: .default) { (_) in
            
            print("Successfully withdrew money")
        }
        
        alert.addAction(cancelAction)
        alert.addAction(withdrawlAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func payBankerAlert(amountToPay: Int) {
        let alert = UIAlertController(title: "Are you sure you want to pay the bank $\(amountToPay)?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let payAction = UIAlertAction(title: "Pay", style: .default) { (_) in
            
            print("Successfully paid bank")
        }
        
        alert.addAction(cancelAction)
        alert.addAction(payAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func updateViews() {
//        guard let banker = BankerController.shared.banker else {return}
//        moneyLabel.text = "\(banker.startingAmount)"
//        bankerImageView.image = ?
        bankerImageView.image = UIImage(named: "bank")?.withRenderingMode(.alwaysTemplate)
        bankerImageView.tintColor = Colors.mintCreme
    }
}
