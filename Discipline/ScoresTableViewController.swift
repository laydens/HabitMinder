//
//  ScoresTableViewController.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/26/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
//import Font_Awesome_Swift


class ScoresTableViewController: UITableViewController {
    
    var goodHabits:NSMutableDictionary = NSMutableDictionary()
    var badHabits:NSMutableDictionary = NSMutableDictionary()
    var AllHabits:NSMutableDictionary = NSMutableDictionary()
    var HabitTracking:NSMutableDictionary = NSMutableDictionary()
    var hasTwoSections = true;
    override func viewWillAppear(_ animated: Bool) {
        let habitData = HabitData()
        let habits:NSMutableArray = habitData.retrieveHabits()!
             for habit in (habits as NSArray as! [Habit]) {
                 CollapseAndUpdateHabit(habit, habitsArray: habits)
         }
    }
    
    
    func CollapseAndUpdateHabit(_ habit:Habit, habitsArray:NSMutableArray)
    {
        if let val = self.HabitTracking[habit.HabitOperator] {
        let newVal:Double = (val as! Double) + (habit.HabitScore*habit.HabitOperatorSize)
            
            if(habit.IsBadHabit)
            {
                self.badHabits[habit.HabitOperator] = newVal
            }
            else{
                self.goodHabits[habit.HabitOperator] = newVal
            }
            
        }
        else{
            let amount = habit.HabitScore * habit.HabitOperatorSize
            if(amount > 0){
            if(habit.IsBadHabit){
                self.badHabits.setValue((habit.HabitScore * habit.HabitOperatorSize), forKey: habit.HabitOperator)
            }
            else{
                self.goodHabits.setValue((habit.HabitScore * habit.HabitOperatorSize), forKey: habit.HabitOperator)
            }
            }
            
        }

        self.HabitTracking.addEntries(from: self.badHabits as NSDictionary as! [AnyHashable: Any])
        self.HabitTracking.addEntries(from: self.goodHabits as NSDictionary as! [AnyHashable: Any])
      //  self.HabitTracking.addEntries(from: from: self.badHabits)
      //  self.HabitTracking.addEntries(from: self.goodHabits as NSMutableDictionary)

        }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
     
         tableView.allowsSelection = false
        
        if(goodHabits.count > 0 && badHabits.count > 0)
        {
          return 2
            
        }else
        {
          self.hasTwoSections = false;
          return 1
        }
       
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var result = 0
        if(hasTwoSections){
            if(section == 0)
            {
                result = badHabits.count
            }
            else
            {
                result = goodHabits.count
            }
        }else{
                result = goodHabits.count + badHabits.count
        }
        
        
        
        return result
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "Penalties" : "Rewards"
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseit")
             let cell = tableView.dequeueReusableCell(withIdentifier: "reuseit", for: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
            //cell.index = indexPath.row
        var dictionary:NSMutableDictionary = NSMutableDictionary()
        if(self.hasTwoSections){
              dictionary = (indexPath as NSIndexPath).section == 0 ? self.badHabits : self.goodHabits}
        else{
              dictionary = self.badHabits
              dictionary.addEntries(from: self.goodHabits as NSDictionary as! [AnyHashable: Any])
         }
        
        
            let key = dictionary.allKeys[(indexPath as NSIndexPath).row]//array.value[indexPath.row]
            let value = dictionary.value(forKey: key as! String) as! Double
            let fixSentence = StringFixer.SentenceCase(key as! String)
        if(value > 0){
            cell.textLabel?.text = "testText"
            cell.textLabel!.text = "\(fixSentence) \(value)"
        }
        
        cell.textLabel?.font = UIFont(name: Constants.FONT_LIGHT, size: 28)
    
            print("test: \(key) \(value)")
            return UITableViewCell()
        }

 
}
