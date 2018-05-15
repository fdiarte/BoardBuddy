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
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateViews()
        
        
    }
    
    @IBAction func requestMoneyButtonPressed(_ sender: Any) {
    }
    
    @IBAction func payBankButtonPressed(_ sender: Any) {
    }
    
    
    func updateViews() {
        guard let banker = BankerController.shared.banker else {return}
        moneyLabel.text = "\(banker.startingAmount)"
//        bankerImageView.image =
    }
}
