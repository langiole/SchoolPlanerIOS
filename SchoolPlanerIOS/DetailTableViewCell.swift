//
//  DetailTableViewCell.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 8/1/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var label: UILabel!    
    var buttons = [UIButton]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        for i in 0...1 {
            let button = UIButton(type: .Custom)
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.bottomAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.bottomAnchor).active = true
            if i == 0 {
                button.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 30).active = true
                button.setTitle("Cancel", forState: .Normal)
                button.addTarget(self, action: #selector(self.cancelButton(_:)), forControlEvents: .TouchUpInside)
            }
            else {
                button.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -30).active = true
                button.setTitle("Options", forState: .Normal)
                button.addTarget(self, action: #selector(self.optionsButton(_:)), forControlEvents: .TouchUpInside)
            }
            button.titleLabel!.font = UIFont.systemFontOfSize(15)
            button.hidden = true
            buttons.append(button)
        }
        
        label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.leftAnchor).active = true
        label.rightAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.rightAnchor).active = true
        label.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        label.font = UIFont.systemFontOfSize(15)
    }
    
    func optionsButton(sender: UIButton) {
        print("options")
    }
    
    func cancelButton(sender: UIButton) {
        print("cancel")

    }
    
    func expanded() {
        for i in 0...buttons.count - 1 {
            buttons[i].hidden = false
        }
    }
    
    func contracted() {
        for i in 0...buttons.count - 1 {
            buttons[i].hidden = true
        }
    }
    
}
