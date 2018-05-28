//
//  instruction3ViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/28/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class Instruction3ViewController: UIViewController {

    @IBOutlet weak var bankerImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bankerImageView.layer.borderWidth = 2
        
        bankerImageView.layer.borderColor = Colors.mintCreme.cgColor
    }

}
