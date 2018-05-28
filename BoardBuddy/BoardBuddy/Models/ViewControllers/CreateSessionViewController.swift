//
//  CreateSessionViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class CreateSessionViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var sessionNameTextField: UITextField!
    @IBOutlet weak var moneyPerPlayerTextField: UITextField!
    @IBOutlet weak var playerNameTextField: UITextField!
    
    @IBOutlet weak var bootButton: UIButton!
    @IBOutlet weak var cannonButton: UIButton!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var moneyButton: UIButton!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var thimbleButton: UIButton!
    @IBOutlet weak var wheelbarrowButton: UIButton!
    @IBOutlet weak var hatButton: UIButton!
    let singleTap = UITapGestureRecognizer()
    var playerImage: UIImage?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        setupObjects()
        sessionNameTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - Methods
    
    func setupObjects() {
        singleTap.addTarget(self, action: #selector(disableKeyboard))
        sessionNameTextField.returnKeyType = .done
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
    
    @objc func disableKeyboard() {
        view.endEditing(true)
    }
    
    //MARK - ButtonMethods
    
    @IBAction func bootButtonTapped(_ sender: Any) {
        print("boot")
        highlight(Button: bootButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "BootIcon")
    }
    @IBAction func cannonButtonTapped(_ sender: Any) {
        print("cannon")
        highlight(Button: cannonButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "CannonIcon")
    }
    @IBAction func dogButtonTapped(_ sender: Any) {
        print("dog")
        highlight(Button: dogButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "DogIcon")
    }
    @IBAction func moneyButtonTapped(_ sender: Any) {
        print("money")
        highlight(Button: moneyButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "MoneyBagIcon")
    }
    @IBAction func carButtonTapped(_ sender: Any) {
        print("car")
        highlight(Button: carButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "RaceCar")
    }
    @IBAction func thimbleButtonTapped(_ sender: Any) {
        print("thimble")
        highlight(Button: thimbleButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "ThimbleIcon")
    }
    
    @IBAction func wheelbarrowButtonTapped(_ sender: Any) {
        print("wheelbarrow")
        highlight(Button: wheelbarrowButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "Wheelbarrow")
    }
    @IBAction func hatButtonTapped(_ sender: Any) {
        print("hat")
        highlight(Button: hatButton)
        self.view.endEditing(true)
        playerImage = #imageLiteral(resourceName: "TophatIcon ")
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func highlight(Button button: UIButton) {
        bootButton.tintColor = Colors.mintCreme
        cannonButton.tintColor = Colors.mintCreme
        dogButton.tintColor = Colors.mintCreme
        moneyButton.tintColor = Colors.mintCreme
        carButton.tintColor = Colors.mintCreme
        thimbleButton.tintColor = Colors.mintCreme
        wheelbarrowButton.tintColor = Colors.mintCreme
        hatButton.tintColor = Colors.mintCreme
        button.tintColor = Colors.green
    }

    @IBAction func createSessionButtonTapped(_ sender: Any) {
        guard let sessionName = sessionNameTextField.text, !sessionName.isEmpty, let image = playerImage else { presentAlert(); return}
        
        //create session
        PlayerController.shared.createNewPlayerWithName(displayName: sessionName, image: image, isHost: true)
        
        //create player
        MPCManager.shared.advertiserAssistant.start()
        
        //push Lobby
        let storyboard = UIStoryboard(name: "Lobby", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "lobby")
        present(view, animated: true, completion: nil)
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Uh Oh", message: "Make sure all fields have a value", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
}

