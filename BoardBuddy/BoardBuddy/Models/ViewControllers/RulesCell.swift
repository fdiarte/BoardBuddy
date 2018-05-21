//
//  RulesCell.swift
//  BoardBuddy
//
//  Created by Hayden Murdock on 5/16/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class RulesCell: UITableViewCell {


    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var rules: String? {
        didSet {
            updateViews()
        }
    }
    
    func setupCell() {
        self.textLabel?.numberOfLines = 0
    }
    
    func updateViews() {
        guard let rules = rules else {return}
        self.textLabel?.textColor = UIColor.white
        self.textLabel?.text = rules
    }
}
