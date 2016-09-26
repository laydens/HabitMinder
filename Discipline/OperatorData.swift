//
//  OperatorData.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/18/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation

class OperatorData {

    private var Rewards:NSMutableArray = NSMutableArray()
    private var Punishments:NSMutableArray = NSMutableArray()
    
    
    func retrievePunishments()->NSMutableArray{
        let data:HabitData = HabitData()
        let hasFile:Bool = data.fileExists(Constants.FILENAME_PUNISHMENTS)
        if(hasFile){
        self.Punishments =  data.retrieveItemsFromFile(Constants.FILENAME_PUNISHMENTS)! as NSMutableArray
        }
        else {
            self.Punishments = Constants.PUNISHMENTS
            data.saveArrayToFile(self.Punishments, FileName: Constants.FILENAME_PUNISHMENTS)
        }
        return self.Punishments
    }
    
    
    
    func retrieveRewards()->NSMutableArray
    {
        let data:HabitData = HabitData()
        let hasFile:Bool = data.fileExists(Constants.FILENAME_REWARDS)
        if(hasFile){
            self.Rewards =  data.retrieveItemsFromFile(Constants.FILENAME_REWARDS)! as NSMutableArray
        }
        else{
            self.Rewards = Constants.REWARDS
            data.saveArrayToFile(self.Rewards, FileName: Constants.FILENAME_REWARDS)
        }
        
        return self.Rewards
    }
    
    func saveRewards(rewards:NSMutableArray)->Bool{
        
        return saveOps(Constants.FILENAME_REWARDS, array: rewards)
        
    }

    func savePunishments(punishments:NSMutableArray)->Bool{
        return saveOps(Constants.FILENAME_PUNISHMENTS, array: punishments)
    
    }


    func saveOps(fileName:String, array:NSMutableArray)->Bool{
        let dataManager:HabitData = HabitData()
        return dataManager.saveArrayToFile(array, FileName: fileName)
    }




}
