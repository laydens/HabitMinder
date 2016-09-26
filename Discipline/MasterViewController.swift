//
//  MasterViewController.swift
//  Discipline
//
//  Created by Shannon Layden on 8/22/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import Material

class MasterViewController: UITableViewController, HabitAdderDelegate {

    var detailViewController: DetailViewController? = nil
    var AllHabits:NSMutableArray = NSMutableArray()
    var SelectedCellIndex:Int = -1


    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let scoreButton = UIBarButtonItem(image: UIImage(named: "scorekeeper_white"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(showScore(_:)))
        //UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: #selector(showScore(_:)))
       
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewHabit(_:)))
        self.navigationItem.rightBarButtonItems = [addButton, scoreButton]
    
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func showScore(sender: AnyObject){
      print("showScore")
    
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        let habitData:HabitData = HabitData()
        self.AllHabits = habitData.retrieveHabits()!
        if(self.tableView != nil && tableView.numberOfRowsInSection(0) != self.AllHabits.count){
            self.tableView.reloadData()}
    }
    
    //User tapped add button, so bump up the score.
    func addSelected(habitCell:HabitTableViewCell)
    {
       let habit:Habit = AllHabits.objectAtIndex(habitCell.index) as! Habit
       habit.HabitScore += 1
       let habitData:HabitData = HabitData()
       habitCell.pulseLabel()
       habitData.saveArrayToFile(AllHabits, FileName: Constants.FILENAME_HABIT)
       self.tableView.reloadData()
       self.SelectedCellIndex = habitCell.index
        habitCell.pulseLabel()
    }
    
   func flashAndFadeCell()
   {
    
    
   }
    
    func fadeIn()
    {
    
    
    }
    
    func fadeOut()
    {
    
    
    }
    
    
    //User tapped refresh, so set it back to zero.
    func refreshSelected(habitCell:HabitTableViewCell)
    {
        let habit:Habit = AllHabits.objectAtIndex(habitCell.index) as! Habit
        habit.HabitScore = 0
        let habitData:HabitData = HabitData()
        habitData.saveArrayToFile(AllHabits,FileName: Constants.FILENAME_HABIT)
        self.tableView.reloadData()
    }
    
    func addNewHabit(sender: AnyObject) {
       performSegueWithIdentifier("ToAddItem", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        objects.insert("test" , atIndex: 0) //NSDate()
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object:Habit = AllHabits[indexPath.row] as! Habit
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object.Title
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllHabits.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tCell", forIndexPath: indexPath) as! HabitTableViewCell
        cell.delegate = self
        cell.index = indexPath.row
        let object = AllHabits[indexPath.row] as! Habit
        cell.lblTitle.text = object.Title
        let payback = object.IsBadHabit ? "You owe" : "You receive"
        let opScore:String = StringFixer.fixNumber(object.HabitScore * object.HabitOperatorSize)
        cell.lblStats.text = "\(payback) \(opScore) \(object.HabitOperator)"
//        if(indexPath.row == self.SelectedCellIndex){
//         cell.pulseLabel()
//            cell.lblStats.textColor = MaterialColor.green.accent1
//        }
        
        self.formatCellButtons(cell, isBadHabit: object.IsBadHabit)
        
        return cell
    }
    
    func formatCellButtons(cell:HabitTableViewCell, isBadHabit:Bool)
    {
        //Add Button
        let colorbase:UIColor = isBadHabit ? MaterialColor.red.base : MaterialColor.green.base
        let colorAccent:UIColor = isBadHabit ? MaterialColor.red.accent1 : MaterialColor.green.accent1
        cell.btnAdd.setFAIcon(FAType.FAPlusSquare, iconSize: 45, forState: .Normal)
        cell.btnAdd.setFATitleColor(colorbase, forState: .Normal)
        cell.btnAdd.setFATitleColor(colorAccent, forState: .Selected)
        
        //Refresh Button
        cell.btnRefresh.setFAIcon(FAType.FARefresh, iconSize: 25, forState: .Normal)
        cell.btnRefresh.setFATitleColor(MaterialColor.lightBlue.base, forState: .Normal)
        cell.btnRefresh.setFATitleColor(MaterialColor.lightBlue.accent3, forState: .Selected)
    
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
       
        if editingStyle == .Delete {
            AllHabits.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let habitData:HabitData = HabitData()
            habitData.saveArrayToFile(AllHabits,FileName: Constants.FILENAME_HABIT)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

