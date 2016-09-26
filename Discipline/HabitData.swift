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

    func saveArrayToFile(items:NSMutableArray, FileName:String)->Bool
{
    let filePath = self.getPath(FileName)
    let success = NSKeyedArchiver.archiveRootObject(items, toFile: filePath);
    print(success)
    return success
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
    let hasFile:Bool = self.fileExists(fileName)
    var habitsOut:NSMutableArray = NSMutableArray()
    if(hasFile){
    habitsOut = (NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? NSMutableArray)!
    
   // var habitArray:NSMutableArray = habitsOut.sort({ (p1:AnyObject!, p2:AnyObject!) -> Bool in
     //       (p1 as! Habit).Title > (p2 as! Habit).Title   })

    print(habitsOut)
    

        
    }
  
    /*
    habitsOut.sortUsingComparator { (h1:Habit, h2:Habit) -> NSComparisonResult in
        if(h1.Title < h2.Title){
          return NSComparisonResult.OrderedAscending
        } else
        {
            return NSComparisonResult.OrderedDescending
        }
    }*/
    return habitsOut
   // return sorted(habitsOut, >) as! NSMutableArray
}

    func fileExists(fileName:String) -> Bool
    {
       let path = self.getPath(fileName)
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    
    }

    func saveHabitsToJSON(habits: NSDictionary)->JSON
    {
    self.json = JSON(habits)
    return self.json
}


    
    
    
    
    

}