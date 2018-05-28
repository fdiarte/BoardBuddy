//
//  instruction5ViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/28/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
protocol instructionPagesDelegate: class {
    func gotItButtonPressed()
}

class Instruction5ViewController: UIViewController {
    @IBOutlet weak var alertImageView: UIImageView!
    
    weak var delegate: instructionPagesDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        alertImageView.layer.borderWidth = 2
        alertImageView.layer.borderColor = Colors.mintCreme.cgColor
    }
    @IBAction func gotItButtonPressed(_ sender: Any) {
        delegate?.gotItButtonPressed()
    }
}
