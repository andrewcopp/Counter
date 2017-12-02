//
//  ListTableViewCell.swift
//  Counter
//
//  Created by Andrew Copp on 12/1/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    lazy var countLabel: UILabel = {
        
        let countLabel: UILabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.font = self.textLabel?.font
        countLabel.backgroundColor = UIColor.clear
        self.addSubview(countLabel)
        
        self.addConstraint(NSLayoutConstraint(item: countLabel,
                                              attribute: NSLayoutAttribute.height,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self.textLabel,
                                              attribute: NSLayoutAttribute.height,
                                              multiplier: 1.0,
                                              constant: 0.0))
        
        self.addConstraint(NSLayoutConstraint(item: countLabel,
                                              attribute: NSLayoutAttribute.width,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: nil,
                                              attribute: NSLayoutAttribute.notAnAttribute,
                                              multiplier: 1.0,
                                              constant: 60.0))
        
        self.addConstraint(NSLayoutConstraint(item: countLabel,
                                              attribute: NSLayoutAttribute.centerY,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self.textLabel,
                                              attribute: NSLayoutAttribute.centerY,
                                              multiplier: 1.0,
                                              constant: 0.0))

        self.addConstraint(NSLayoutConstraint(item: countLabel,
                                              attribute: NSLayoutAttribute.right,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.right,
                                              multiplier: 1.0,
                                              constant: 0.0))
        
        return countLabel
        
    }()

}
