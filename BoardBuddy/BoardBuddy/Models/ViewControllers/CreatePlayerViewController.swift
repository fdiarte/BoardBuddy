//
//  CreatePlayerViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class CreatePlayerViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties

    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var bootButton: UIButton!
    @IBOutlet weak var cannonButton: UIButton!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var moneyButton: UIButton!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var thimbleButton: UIButton!
    @IBOutlet weak var wheelBarrowButton: UIButton!
    @IBOutlet weak var hatButton: UIButton!
    var playerImage: UIImage?
    let singleTap = UITapGestureRecognizer()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        playerNameTextField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    //MARK: - Methods
    
    func setupObjects() {
        playerNameTextField.returnKeyType = .done
        singleTap.addTarget(self, action: #selector(tapGestureTapped))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func keyBoardWillShow() {
        view.addGestureRecognizer(singleTap)
    }
    
    @objc func keyBoardWillHide() {
        view.removeGestureRecognizer(singleTap)
    }
    
    @objc func tapGestureTapped() {
        view.endEditing(true)
    }

    @IBAction func bootButtonPressed(_ sender: Any) {
        print("boot")
        highlight(Button: bootButton)
        playerImage = #imageLiteral(resourceName: "BootIcon")
    }
    
    @IBAction func cannonButtonPressed(_ sender: Any) {
        print("cannon")
        highlight(Button: cannonButton)
        playerImage = #imageLiteral(resourceName: "CannonIcon")
        
    }
    @IBAction func dogButtonPressed(_ sender: Any) {
        print("dog")
        highlight(Button: dogButton)
        playerImage = #imageLiteral(resourceName: "DogIcon")
        
    }
    @IBAction func moneyBagButtonPressed(_ sender: Any) {
        print("money")
        highlight(Button: moneyButton)
        playerImage = #imageLiteral(resourceName: "MoneyBagIcon")
        
    }
    
    @IBAction func raceCarButtonPressed(_ sender: Any) {
        print("car")
        highlight(Button: carButton)
        playerImage = #imageLiteral(resourceName: "RaceCar")
        
    }
    
    @IBAction func thimbleButtonPressed(_ sender: Any) {
        print("thimble")
        highlight(Button: thimbleButton)
        playerImage = #imageLiteral(resourceName: "ThimbleIcon")
        
    }
    
    @IBAction func wheelBarrowButtonPressed(_ sender: Any) {
        print("wheelbarrow")
        highlight(Button: wheelBarrowButton)
        playerImage = #imageLiteral(resourceName: "Wheelbarrow")
        
    }
    
    @IBAction func topHotButtonPressed(_ sender: Any) {
        print("hat")
        highlight(Button: hatButton)
        playerImage = #imageLiteral(resourceName: "TophatIcon ")
        
    }
    
    @IBAction func readyButtonPressed(_ sender: Any) {
        guard let image = playerImage, let name = playerNameTextField.text, !name.isEmpty else { presentAlert() ; return }
        
        
         //create player
        PlayerController.shared.createNewPlayerWithName(displayName: name, image: image, isHost: false)
        MPCManager.shared.delegate = self
        MPCManager.shared.browser.delegate = self
        
        present(MPCManager.shared.browser, animated: true, completion: nil)
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Uh Oh", message: "Make sure all fields have a value", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
    
    func highlight(Button button: UIButton) {
        bootButton.tintColor = Colors.mintCreme
        cannonButton.tintColor = Colors.mintCreme
        dogButton.tintColor = Colors.mintCreme
        moneyButton.tintColor = Colors.mintCreme
        carButton.tintColor = Colors.mintCreme
        thimbleButton.tintColor = Colors.mintCreme
        wheelBarrowButton.tintColor = Colors.mintCreme
        hatButton.tintColor = Colors.mintCreme
        button.tintColor = Colors.green
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension CreatePlayerViewController: MPCManagerDelegate, MCBrowserViewControllerDelegate {
    func sessionNotConnected() {
    }    
    func matchEndedRecieved(from data: Data) {
    }    
    func requestFundsRecieved(from data: Data) {
    }
    func acceptedFundsRecieved(from data: Data) {
    }
    func playersArrayRecieved(from data: Data) {
    }
    func infoRecieved(from data: Data) {
    }
    func playerRecieved(from data: Data) {
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }

    func playerJoinedSession() {
        //transition to lobby
//        MPCManager.shared.sendPerson(player: PlayerController.shared.players.first!)
        dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Lobby", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "lobby")
        present(view, animated: true, completion: nil)
    }
}
