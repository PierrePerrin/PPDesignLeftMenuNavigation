//
//  PPLeftMenuCellTableViewCell.swift
//  PPLeftMenuNavigation
//
//  Created by Pierre Perrin on 06/04/2017.
//  Copyright © 2017 PierrePerrin. All rights reserved.
//

import UIKit

class PPLeftMenuTableViewCell: UITableViewCell {

    func prepareUi(){
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundView = nil
    }

    var leftMenuItem : PPLeftMenuItem?{
        didSet{
            
            self.textLabel?.text = leftMenuItem?.text
            self.imageView?.image = leftMenuItem?.icon
            self.textLabel?.textColor = leftMenuItem?.textColor
            self.textLabel?.font = leftMenuItem?.font
            self.prepareUi()
        }
    }
}
