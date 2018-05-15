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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        MPCManager.shared.advertiserAssistant.start()
        // Segue to lobby
        let storyboard = UIStoryboard(name: "Lobby", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "lobby")
        present(view, animated: true, completion: nil)
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        MPCManager.shared.browser.delegate = self
        present(MPCManager.shared.browser, animated: true, completion: nil)
    }
}

extension EntryScreenViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Lobby", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "lobby")
        present(view, animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
        // Segue to lobby
    }
}
