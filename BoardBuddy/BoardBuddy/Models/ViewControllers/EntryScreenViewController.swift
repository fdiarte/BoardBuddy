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
        setupButtons()
    }
    
    func setupButtons() {
        createSessionButton.layer.cornerRadius = 20
        joinSessionButton.layer.cornerRadius = 20
        
        createSessionButton.setTitle("Create Session", for: .normal)
        joinSessionButton.setTitle("Join Session", for: .normal)
    }
}

