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


    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewHabit(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
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
        habitData.saveHabitsToFile(AllHabits, FileName: Constants.FILENAME_HABIT)
       self.tableView.reloadData()
    }
    
    //User tapped refresh, so set it back to zero.
    func refreshSelected(habitCell:HabitTableViewCell)
    {
        let habit:Habit = AllHabits.objectAtIndex(habitCell.index) as! Habit
        habit.HabitScore = 0
        let habitData:HabitData = HabitData()
        habitData.saveHabitsToFile(AllHabits,FileName: Constants.FILENAME_HABIT)
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
        cell.lblStats.text = "You owe \(object.HabitScore * object.HabitOperatorSize) \(object.HabitOperator)"
        
        self.formatCellButtons(cell)
        
        return cell
    }
    
    func formatCellButtons(cell:HabitTableViewCell)
    {
        //Add Button
        cell.btnAdd.setFAIcon(FAType.FAPlusSquare, iconSize: 45, forState: .Normal)
        cell.btnAdd.setFATitleColor(MaterialColor.blue.base, forState: .Normal)
        cell.btnAdd.setFATitleColor(MaterialColor.blue.accent3, forState: .Selected)
        
        //Refresh Button
        cell.btnRefresh.setFAIcon(FAType.FARefresh, iconSize: 25, forState: .Normal)
        cell.btnRefresh.setFATitleColor(MaterialColor.lightGreen.base, forState: .Normal)
        cell.btnRefresh.setFATitleColor(MaterialColor.lightGreen.accent3, forState: .Selected)
    
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
            habitData.saveHabitsToFile(AllHabits,FileName: Constants.FILENAME_HABIT)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

