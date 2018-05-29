//
//  EntryScreenViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class EntryScreenViewController: UIViewController {
    @IBOutlet weak var createSessionButton: UIButton!
    @IBOutlet weak var joinSessionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.setupButtons()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
    }
    
    func setupButtons() {
        DispatchQueue.main.async {
            self.createSessionButton.layer.cornerRadius = 20
            self.joinSessionButton.layer.cornerRadius = 20
            
            self.createSessionButton.setTitle("Create Game", for: .normal)
            self.joinSessionButton.setTitle("Find Game", for: .normal)
        }
    }
}

