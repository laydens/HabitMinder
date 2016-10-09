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
        guard let title = decoder.decodeObject(forKey: "title") as? String,
            let habitoperator = decoder.decodeObject(forKey: "habitoperator") as? String,
            let summary = decoder.decodeObject(forKey: "summary") as? String
            else { return nil }
        
        
        self.init(
            title: title,
            habitOperatorSize: decoder.decodeDouble(forKey: "habitoperatorsize"),
            habitoperator: habitoperator,
            isbadHabit:decoder.decodeBool(forKey: "isbadhabit")
        )
        self.Summary = summary
        self.HabitScore = decoder.decodeDouble(forKey: "habitscore")
    }
    
    
    
    func encode(with coder: NSCoder) {
        coder.encode(self.Title, forKey: "title")
        coder.encode(self.Summary, forKey: "summary")
        coder.encode(self.HabitOperator, forKey: "habitoperator")
        coder.encode(self.HabitOperatorSize, forKey: "habitoperatorsize")
        coder.encode(self.IsBadHabit, forKey: "isbadhabit")
        coder.encode(self.HabitScore, forKey: "habitscore")
    }
}


func < (lhs: Habit, rhs: Habit) -> Bool {
    return lhs.Title < rhs.Title
}
