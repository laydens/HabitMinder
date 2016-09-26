//
//  Habit.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/5/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation
class Habit: NSObject, Comparable, NSCoding {
    var Title:String
    var Summary:String
    var HabitOperatorSize:Double
    var HabitOperator:String
    var HabitScore:Double
    var IsBadHabit:Bool = true
    
    init(title:String, habitOperatorSize:Double, habitoperator:String, isbadHabit:Bool){
        
        self.Title = title
        self.IsBadHabit = isbadHabit
        self.HabitOperator = habitoperator
        self.HabitOperatorSize = habitOperatorSize
        self.Summary = ""
        self.HabitScore = 0.0
        super.init()
    }
   
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObjectForKey("title") as? String,
            let habitoperator = decoder.decodeObjectForKey("habitoperator") as? String,
            let summary = decoder.decodeObjectForKey("summary") as? String
            else { return nil }
        
        
        self.init(
            title: title,
            habitOperatorSize: decoder.decodeDoubleForKey("habitoperatorsize"),
            habitoperator: habitoperator,
            isbadHabit:decoder.decodeBoolForKey("isbadhabit")
        )
        self.Summary = summary
        self.HabitScore = decoder.decodeDoubleForKey("habitscore")
    }
    
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.Title, forKey: "title")
        coder.encodeObject(self.Summary, forKey: "summary")
        coder.encodeObject(self.HabitOperator, forKey: "habitoperator")
        coder.encodeDouble(self.HabitOperatorSize, forKey: "habitoperatorsize")
        coder.encodeBool(self.IsBadHabit, forKey: "isbadhabit")
        coder.encodeDouble(self.HabitScore, forKey: "habitscore")
    }
}


func < (lhs: Habit, rhs: Habit) -> Bool {
    return lhs.Title < rhs.Title
}