//
//  SideMenuCollectionViewCell.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/17/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class SlideMenuCollectionViewCell: UICollectionViewCell {
    var setting: Setting? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var SideMenuItemImage: UIImageView!
    @IBOutlet weak var sideMenuItemLabel: UILabel!
    
    func updateViews() {
        guard let setting = setting else {return}
        sideMenuItemLabel.text = setting.name
        SideMenuItemImage.image = UIImage(named: setting.imageName)
    }
}
