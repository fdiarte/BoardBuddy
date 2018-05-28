//
//  Instruction1ViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/28/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class Instruction1ViewController: UIViewController {

    @IBOutlet weak var createOrJoinImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createOrJoinImageView.layer.borderWidth = 2
        createOrJoinImageView.layer.borderColor = Colors.mintCreme.cgColor

    }
}
