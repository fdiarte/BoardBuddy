//
//  instruction2ViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/28/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class Instruction2ViewController: UIViewController {

    @IBOutlet weak var lobbyImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lobbyImageView.layer.borderWidth = 2
        lobbyImageView.layer.borderColor = Colors.mintCreme.cgColor
    }
}
