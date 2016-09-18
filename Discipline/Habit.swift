//
//  Habit.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/5/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation
class Habit: NSObject, NSCoding {
    var Title:String
    var Summary:String
    var HabitOperatorSize:Int
    var HabitOperator:String
    var HabitScore:Int
    
    init(title:String, habitOperatorSize:Int, habitoperator:String){
    
        self.Title = title
        self.HabitOperator = habitoperator
        self.HabitOperatorSize = habitOperatorSize
        self.Summary = ""
        self.HabitScore = 0
        super.init()
    }
    
    
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObjectForKey("title") as? String,
        let habitoperator = decoder.decodeObjectForKey("habitoperator") as? String,
        let summary = decoder.decodeObjectForKey("summary") as? String
        else { return nil }
        
        
   self.init(
            title: title,
            habitOperatorSize: decoder.decodeIntegerForKey("habitoperatorsize"),
            habitoperator: habitoperator
        )
        self.Summary = summary
        self.HabitScore = decoder.decodeIntegerForKey("habitscore")
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.Title, forKey: "title")
        coder.encodeObject(self.Summary, forKey: "summary")
        coder.encodeObject(self.HabitOperator, forKey: "habitoperator")
        coder.encodeInt32(Int32(self.HabitOperatorSize), forKey: "habitoperatorsize")
        coder.encodeInt32(Int32(self.HabitScore), forKey: "habitscore")
    }
    
}