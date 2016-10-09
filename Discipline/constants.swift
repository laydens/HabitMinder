//
//  constants.swift
//  Discipline
//
//  Created by Shannon Layden on 8/28/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation

public struct Constants {
    
    static let FILENAME_HABIT: String = "habits.archive"
    static let FILENAME_PUNISHMENTS: String = "punishments.archive"
    static let FILENAME_REWARDS: String = "rewards.archive"
    static let ERROR_REQUIRED_HABIT_TITLE: String = "Please enter a habit"
    static let ERROR_REQUIRED_OPERATOR: String = "Please choose a punishment or reward"
    static let FONT_LIGHT: String = "HelveticaNeue-UltraLight"
    static let FONT_BOLD: String = "HelveticaNeue-Bold"
    static let FONT_REG: String = "HelveticaNeue-Light"
    static let PUNISHMENTS:NSMutableArray = ["Push ups", "Dollars", "TV nights", "Laps", "Points"]
    static let REWARDS:NSMutableArray = ["Points", "Dollars"]
    enum Operator {
        case reward
        case punishment
    }
    
}
