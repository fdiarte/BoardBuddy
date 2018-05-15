//
//  HomeScreenViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var boardPieceImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlayerController.shared.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        
        return cell
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBankDetailVC" {
            
        } else if segue.identifier == "toPlayerDetailVC" {
            
        }
    }
}
