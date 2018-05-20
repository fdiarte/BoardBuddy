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
        createSessionButton.layer.cornerRadius = 20
        joinSessionButton.layer.cornerRadius = 20
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
    }
}

