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
    
    weak var delegate: instructionPagesDelegate?

    @IBAction func gotItButtonPressed(_ sender: Any) {
        delegate?.gotItButtonPressed()
    }
}
