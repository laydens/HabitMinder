//
//  HabitOperatorViewController.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/10/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit

class HabitOperatorViewController: UITableViewController {

    var HabitOperators:NSMutableArray = NSMutableArray()
    var SelectedOperatorIndex:Int = 0
    var isPunishment:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HabitOperators = self.retrieveHabitOperators()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewOperator(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.SelectedOperatorIndex = indexPath.row
        let presenting:AddItemViewController = self.presentingViewController as! AddItemViewController
        presenting.HabitOperator = self.HabitOperators[self.SelectedOperatorIndex] as! String
        presenting.isBadHabit = self.isPunishment
         self.navigationController?.dismissViewControllerAnimated(true, completion: {
            
         })
    }
    
    override func viewWillAppear(animated: Bool) {
        HabitOperators = retrieveHabitOperators()
        self.tableView.reloadData()
    }
    
    func addNewOperator(sender: AnyObject) {
        performSegueWithIdentifier("AddOperator", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is AddOperatorViewController)
        {
            
            let habitOpController:AddOperatorViewController =  segue.destinationViewController as! AddOperatorViewController
            habitOpController.isPunishment = self.isPunishment
        }
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HabitOperators.count
    }
    

 

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = StringFixer.MakeOperatorPlural(HabitOperators[indexPath.row].capitalizedString)
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func retrieveHabitOperators()->NSMutableArray
    {

        let OpDataManager:OperatorData = OperatorData()
        self.HabitOperators = self.isPunishment ? OpDataManager.retrievePunishments() : OpDataManager.retrieveRewards()
        return self.HabitOperators
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
