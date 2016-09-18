//
//  Habits.swift
//  Discipline
//
//  Created by Shannon Layden on 9/5/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation

class HabitData
{

var json:JSON = []

    func saveHabitsToFile(habits:NSMutableArray, FileName:String)
{
    let filePath = self.getPath(FileName)
    let success = NSKeyedArchiver.archiveRootObject(habits, toFile: filePath);
    print(success)
/*
    if let names:NSMutableArray = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? NSMutableArray {
      print(names) //habitsOut = names
    }
    
*/
    
}
    
    func retrieveHabits() ->NSMutableArray?
    {
        return retrieveItemsFromFile(Constants.FILENAME_HABIT)
    }
    

func getPath(FileName:String)->String{
    let paths:NSArray = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory,.UserDomainMask, true) as NSArray;
    let documentsDirectory:String = paths[0] as! String;
    let filePath:String = documentsDirectory.stringByAppendingString(FileName);
    return filePath
}



func retrieveItemsFromFile(fileName:String) ->NSMutableArray?
{
    let path = self.getPath(fileName)
    let hasFile:Bool = NSFileManager.defaultManager().fileExistsAtPath(path)
    var habitsOut:NSMutableArray = NSMutableArray()
    if(hasFile){
    habitsOut = (NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? NSMutableArray)!
    print(habitsOut)
    }
    return habitsOut
}


    func saveHabitsToJSON(habits: NSDictionary)->JSON
    {
    self.json = JSON(habits)
    return self.json
}


    
    
    
    
    

}