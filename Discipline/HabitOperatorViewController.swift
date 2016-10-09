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
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewOperator(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.SelectedOperatorIndex = (indexPath as NSIndexPath).row
        let presenting:AddItemViewController = self.presentingViewController as! AddItemViewController
        presenting.HabitOperator = self.HabitOperators[self.SelectedOperatorIndex] as! String
        presenting.isBadHabit = self.isPunishment
        presenting.habit?.HabitOperator = presenting.HabitOperator
         self.navigationController?.dismiss(animated: true, completion: {
            
         })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HabitOperators = retrieveHabitOperators()
        self.tableView.reloadData()
    }
    
    func addNewOperator(_ sender: AnyObject) {
        performSegue(withIdentifier: "AddOperator", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is AddOperatorViewController)
        {
            
            let habitOpController:AddOperatorViewController =  segue.destination as! AddOperatorViewController
            habitOpController.isPunishment = self.isPunishment
        }
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HabitOperators.count
    }
    

 

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        cell.textLabel?.text = StringFixer.MakeOperatorPlural((HabitOperators[(indexPath as NSIndexPath).row] as AnyObject).capitalized)
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.HabitOperators.remove(self.HabitOperators[(indexPath as NSIndexPath).row])
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        let opData:OperatorData =  OperatorData()
        let saveSucces = self.isPunishment ? opData.savePunishments(self.HabitOperators) : opData.saveRewards(self.HabitOperators)
            print(saveSucces)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    /*
 let opData:OperatorData =  OperatorData()
 let ops:NSMutableArray = isPunishment ? opData.retrievePunishments() : opData.retrieveRewards()
 ops.addObject(txtOperatorField.text!)
 let saveSucces = isPunishment ? opData.savePunishments(ops) : opData.saveRewards(ops)
 print(saveSucces)
*/
 
 
    func retrieveHabitOperators()->NSMutableArray
    {
        let OpDataManager:OperatorData = OperatorData()
        self.HabitOperators = self.isPunishment ? OpDataManager.retrievePunishments() : OpDataManager.retrieveRewards()
        return self.HabitOperators
    }
    
    /*
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
 */


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
