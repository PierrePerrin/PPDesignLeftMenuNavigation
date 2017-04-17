//
//  PPLeftItem.swift
//  PPLeftMenuNavigation
//
//  Created by Pierre Perrin on 06/04/2017.
//  Copyright © 2017 PierrePerrin. All rights reserved.
//

import Foundation
import UIKit

public class PPLeftMenuItem {
    
    public var text :String
    public var icon : UIImage?
    public var textColor : UIColor = UIColor.white
    public var font : UIFont = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
    
    public init(WithText text : String, icon : UIImage?) {
        
        self.text = text
        self.icon = icon
    }
}
