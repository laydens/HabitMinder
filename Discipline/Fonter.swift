//
//  Fonter.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/15/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation
import UIKit

class Fonter {

    static func fixlabel(_ label:UILabel){
    label.font = UIFont(name: Constants.FONT_REG, size: 20)
    }
    
    static func fixbutton(_ button:UIButton){
        button.titleLabel!.font = UIFont(name: Constants.FONT_REG, size: 18)
    }
    
    static func fixTextField(_ text:UITextField){
       text.font = UIFont(name: Constants.FONT_REG, size: 20)
    
    }


}
