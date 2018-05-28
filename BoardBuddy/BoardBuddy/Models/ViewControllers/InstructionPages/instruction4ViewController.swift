//
//  instruction4ViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/28/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class Instruction4ViewController: UIViewController {

    @IBOutlet weak var playerImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        playerImageView.layer.borderWidth = 2
        playerImageView.layer.borderColor = Colors.mintCreme.cgColor
    }

}
