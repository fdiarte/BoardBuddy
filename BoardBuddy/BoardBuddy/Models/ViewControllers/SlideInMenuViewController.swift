//
//  SlideInMenuViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/17/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
class Setting: NSObject {
    let name: String
    let imageName: String
    let number: Int
    
    init(name: String, imageName: String, number: Int) {
        self.name = name
        self.imageName = imageName
        self.number = number
    }
}

protocol SlideInMenuViewControllerDelegate: class {
    func settingTapped(settingNumber: Int)
}

class SlideInMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: SlideInMenuViewControllerDelegate?

    let settings: [Setting] = {
        let rules = Setting(name: "Rules", imageName: "rules", number: 1)
        let leaveMatch = Setting(name: "Leave Match", imageName: "leave", number: 2)
        let cancelMatch = Setting(name: "Cancel Match", imageName: "leave", number: 3)
        return [rules, leaveMatch, cancelMatch]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingCell", for: indexPath) as! SlideMenuCollectionViewCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.05)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.settingTapped(settingNumber: indexPath.row)
        print("tapped \(indexPath.row)")
    }
}
