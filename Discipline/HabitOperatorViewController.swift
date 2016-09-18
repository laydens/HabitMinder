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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewOperator(_:)))
        self.navigationItem.rightBarButtonItem = addButton
      //  if let split = self.splitViewController {
       //     let controllers = split.viewControllers
          //  self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.SelectedOperatorIndex = indexPath.row
        let presenting:AddItemViewController = self.presentingViewController as! AddItemViewController
        
        presenting.HabitOperator = self.HabitOperators[self.SelectedOperatorIndex] as! String
         self.navigationController?.dismissViewControllerAnimated(true, completion: {
            
         })
    }
    
    override func viewWillAppear(animated: Bool) {
        HabitOperators = retrieveHabitOperators()
    }
    
    func addNewOperator(sender: AnyObject) {
        performSegueWithIdentifier("AddOperator", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       
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
        let habitData:HabitData = HabitData()
        self.HabitOperators = habitData.retrieveItemsFromFile(Constants.FILENAME_OPERATORS)!
        
        if self.HabitOperators.count > 0{
            return self.HabitOperators
        }
        else{
            return Constants.OPERATORS
        }
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
