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
import Crashlytics

class MasterViewController: UITableViewController, HabitAdderDelegate {

    var detailViewController: DetailViewController? = nil
    var AllHabits:NSMutableArray = NSMutableArray()
    var SelectedCellIndex:Int = -1


    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //  self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
          //  Crashlytics.sharedInstance().crash()
        

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewHabit(_:)))
        let scoreButton = CreateScoreButton()
       // let helpButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action:#selector(showHelp(_:)))

        self.navigationItem.rightBarButtonItems = [addButton, scoreButton]
        self.navigationItem.leftBarButtonItems = [self.editButtonItem]
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func CreateScoreButton() -> UIBarButtonItem
    {
        let scoreButtonImage = UIImage(named: "scorekeeper_white")
        let size = CGSize(width: 25, height: 30)
        let scoreButtonImageResize = imageResize(scoreButtonImage!, sizeChange: size)
        let scoreButton = UIBarButtonItem(image: scoreButtonImageResize, style: UIBarButtonItemStyle.plain, target: self, action: #selector(showScore(_:)))
        return scoreButton
    }
    
    func showHelp(_ sender: AnyObject){
      print("showHelp")
        
    }
    
    func showScore(_ sender: AnyObject){
      print("showScore")
        
        let scoreVC:ScoresTableViewController = ScoresTableViewController()
        self.navigationController?.pushViewController(scoreVC, animated: true)
    
    }
    
    func imageResize (_ image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }

        override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        let habitData:HabitData = HabitData()
        self.AllHabits = habitData.retrieveHabits()!
       
        if(self.tableView != nil){
            self.tableView.reloadData()}
    }
    
    //User tapped add button, so bump up the score.
    func addSelected(_ habitCell:HabitTableViewCell)
    {
       let habit:Habit = AllHabits.object(at: habitCell.index) as! Habit
       habit.HabitScore += 1
       let habitData:HabitData = HabitData()
       habitCell.pulseLabel()
        let success = habitData.saveArrayToFile(AllHabits, FileName: Constants.FILENAME_HABIT)
        print(success)
       self.tableView.reloadData()
       self.SelectedCellIndex = habitCell.index
        habitCell.pulseLabel()
        Answers.logCustomEvent(withName: "RecordHabitOccured",
                                       customAttributes: [
                                        "Type": habit.IsBadHabit ? "badhabit" : "goodhabit",
                                        "Custom Number": 35])

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
    func refreshSelected(_ habitCell:HabitTableViewCell)
    {
        let habit:Habit = AllHabits.object(at: habitCell.index) as! Habit
        habit.HabitScore = 0
        let habitData:HabitData = HabitData()
        habitData.saveArrayToFile(AllHabits,FileName: Constants.FILENAME_HABIT)
        self.tableView.reloadData()
    }
    
    func addNewHabit(_ sender: AnyObject) {
       performSegue(withIdentifier: "ToAddItem", sender: self)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object:Habit = AllHabits[(indexPath as NSIndexPath).row] as! Habit
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object.Title as AnyObject?
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if segue.identifier == "ToEditHabit" {
            let controller = segue.destination as! AddItemViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
             controller.habit = self.AllHabits[(indexPath as NSIndexPath).row] as? Habit
            controller.habitIndex = (indexPath as NSIndexPath).row
            }
        }
    }
    

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllHabits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! HabitTableViewCell
        cell.delegate = self
        cell.index = (indexPath as NSIndexPath).row
        let object = AllHabits[(indexPath as NSIndexPath).row] as! Habit
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
    
    func formatCellButtons(_ cell:HabitTableViewCell, isBadHabit:Bool)
    {
        //Add Button
        let colorbase:UIColor = isBadHabit ? Color.red.base : Color.green.base
        let colorAccent:UIColor = isBadHabit ? Color.red.accent1 : Color.green.accent1
        cell.btnAdd.setFAIcon(icon: FAType.FAPlusSquare, iconSize: 45, forState: UIControlState())
        cell.btnAdd.setFATitleColor(color: colorbase, forState: UIControlState())
        cell.btnAdd.setFATitleColor(color: colorAccent, forState: .selected)
        
        //Refresh Button
        cell.btnRefresh.setFAIcon(icon: FAType.FARefresh, iconSize: 25, forState: UIControlState())
        cell.btnRefresh.setFATitleColor(color: Color.lightBlue.base, forState: UIControlState())
        cell.btnRefresh.setFATitleColor(color: Color.lightBlue.accent3, forState: .selected)
    
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
            AllHabits.removeObject(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let habitData:HabitData = HabitData()
            habitData.saveArrayToFile(AllHabits,FileName: Constants.FILENAME_HABIT)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

