//
//  secondLaunchViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/28/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class secondLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isNewUser()
    }
    
    func isNewUser() {
        if UserDefaults.standard.object(forKey: "isCurrentUser") as? Bool == true {
            segueToEntryScreen()
        } else {
            segueToInstructions()
        }
    }
    deinit {
        print("Second launch screen deallocted")
    }
    
    func segueToEntryScreen() {
        let entryStoryBoard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let view = entryStoryBoard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(view, animated: true, completion: nil)
        print("is current user")
    }
    
    func segueToInstructions() {
        let instructionsStoryboard = UIStoryboard(name: "Instructions", bundle: nil)
        let view = instructionsStoryboard.instantiateViewController(withIdentifier: "instructionPage")
        self.present(view, animated: true, completion: nil)
        print("is not a current user")
    }
}
