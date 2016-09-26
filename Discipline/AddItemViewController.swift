//
//  AddItemViewController.swift
//  Discipline
//
//  Created by Shannon Layden on 8/28/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
import Material
import GMStepper



class AddItemViewController : UIViewController {
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var sprIncrement: UIStepper!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var stpOperatorStepper: UIStepper!
    @IBOutlet weak var btnBadHabitOperator: RaisedButton!
    @IBOutlet weak var btnGoodHabitOperator: RaisedButton!

    var HabitOperator:String = ""
    var HabitMultiplyer:Double = 0
    var isBadHabit = true
    
    @IBOutlet weak var txtHabitText: TextField!
    @IBOutlet weak var lblOperator: MaterialLabel!
   // private var txtkHabitText:TextField!
    var json:JSON = []
    var habits:NSMutableArray?
   
    @IBAction func stpStep(sender: AnyObject) {
        
        let stepper:UIStepper = sender as! UIStepper
        print(stepper.value)
        self.HabitMultiplyer = stepper.value
        let score = String(Int(self.HabitMultiplyer))
        self.lblScore.text = isBadHabit ? "Owe \(score)" : "Receive \(score)"
    }
    
    @IBAction func btnBadHabitAction(sender: AnyObject) {
        self.isBadHabit = true
    }
    
    @IBAction func btnGoodHabitAction(sender: AnyObject) {
        self.isBadHabit = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    override func viewWillAppear(animated: Bool) {
        
        if(self.HabitOperator.isEmpty){
          self.setEmptyState()
        }else
        {
            self.setEditState()
        }
        
    }
    
    func setEmptyState(){
        
        self.txtHabitText.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.txtHabitText.placeholder = "My Habit"
        self.prepareBadOperatorButton()
        self.prepareGoodOperatorButton()
        self.stpOperatorStepper.hidden = true
        self.lblOperator.hidden = true
        self.lblScore.hidden = true
    }
    
    func setEditState(){
        self.HabitMultiplyer = self.stpOperatorStepper.value
        self.lblOperator.text  = self.HabitOperator
        self.txtHabitText.placeholder = ""
        self.setOperator()
        self.txtHabitText.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.prepareStepper()
       // self.prepareOperatorLabel()
        self.prepareHabitTextField()
        self.hideButtons()
        self.stpOperatorStepper.hidden = false
        self.lblOperator.hidden = false
        self.lblScore.hidden = false
        
   
     }
    
    func setOperator(){
        self.lblScore.hidden = false
        self.lblScore.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.lblScore.text = String(self.HabitMultiplyer)
        self.lblScore.text = self.isBadHabit ? "Owe \(String(Int(self.stpOperatorStepper.value)))" : "Receive \(String(Int(self.stpOperatorStepper.value)))"
        self.lblOperator.hidden = false
        self.lblOperator.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.lblOperator.text = StringFixer.MakeOperatorPlural(self.HabitOperator)

    }
    
    func hideButtons()
    {
        self.btnBadHabitOperator.hidden = true
        self.btnGoodHabitOperator.hidden = true
    }
    
    func prepareStepper()
    {
        let stepper:GMStepper = GMStepper()
        self.view.addSubview(stepper)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        txtHabitText.becomeFirstResponder()
        self.habits = retrieveBadHabits()
        super.viewDidAppear(true)
        btnCancel.title = "Cancel"
      
    }
    
    func prepareOperatorLabel()
    {
     Fonter.fixlabel(self.lblOperator)
        self.view.layout(lblOperator).top(150).horizontally(left: 40, right: 40)
        let OperatorType:String = isBadHabit ? "Penalty":"Reward"
        let FixedOperator:String = StringFixer.MakeOperatorPlural(self.HabitOperator)
        self.lblOperator.text = "\(OperatorType): \(FixedOperator)"
    }
    
    func prepareBadOperatorButton()
    {
        Fonter.fixbutton(self.btnBadHabitOperator)
    //self.btnBadHabitOperator = RaisedButton()9
 //   self.btnBadHabitOperator.titleLabel?.font = Fontfix.setlabelfont(UILabel())
    self.btnBadHabitOperator.titleLabel?.font = UIFont(name: Constants.FONT_REG, size: 20)!
    self.btnBadHabitOperator.setTitle("Punish", forState: .Normal)
    self.btnBadHabitOperator.setTitleColor(MaterialColor.white, forState: .Normal)
    self.btnBadHabitOperator.pulseColor = MaterialColor.red.accent4
    self.btnBadHabitOperator.backgroundColor = MaterialColor.red.base

    }
    
    func prepareGoodOperatorButton()
    {
        //self.btnGoodHabitOperator = RaisedButton()
        Fonter.fixbutton(self.btnGoodHabitOperator)
        self.btnGoodHabitOperator.titleLabel?.font = UIFont(name: Constants.FONT_REG, size: 20)!
        self.btnGoodHabitOperator.setTitle("Reward", forState: .Normal)
        self.btnGoodHabitOperator.setTitleColor(MaterialColor.white, forState: .Normal)
        self.btnGoodHabitOperator.pulseColor = MaterialColor.green.accent4
        self.btnGoodHabitOperator.backgroundColor = MaterialColor.green.base
        self.btnGoodHabitOperator.systemLayoutSizeFittingSize(CGSize(width: 70,height: 20))

    }
    
   func prepareHabitTextField()
    {
    self.txtHabitText.clearButtonMode = .WhileEditing
    }
    
    
    
    @IBAction func save(sender: AnyObject) {
        //let still allows mutable array to be changed. Just not reassigned.
        
        if let habit = txtHabitText.text where !habit.isEmpty{
        let Operator:String = StringFixer.MakeOperatorPlural(self.HabitOperator.lowercaseString)
         let newHabit:Habit = Habit(title: habit, habitOperatorSize: self.HabitMultiplyer, habitoperator: Operator, isbadHabit: self.isBadHabit)
         self.habits!.addObject(newHabit)
         let habitData:HabitData = HabitData()
         habitData.saveArrayToFile(self.habits!, FileName: Constants.FILENAME_HABIT)
        }
        else{
            raiseEmptyTextError()
        }
        btnCancel.title = "Done"
        self.dismissViewControllerAnimated(true) {
            //
        }


    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        
        self.dismissViewControllerAnimated(true) {
            //
        }
        
    }
    
    func raiseEmptyTextError(){
        // create the alert
        let alert = UIAlertController(title: "Oops", message: Constants.ERROR_REQUIRED_HABIT_TITLE, preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if(segue.destinationViewController is UINavigationController)
       {
        let navController:UINavigationController = segue.destinationViewController as! UINavigationController
        let habitOpController:HabitOperatorViewController =  navController.viewControllers[0] as! HabitOperatorViewController
        habitOpController.isPunishment = self.isBadHabit
        }
    }
    
    func retrieveBadHabits()->NSMutableArray{
        if self.habits != nil {
            return self.habits!
        }
        else{
            let habitData:HabitData = HabitData()
            self.habits = habitData.retrieveItemsFromFile(Constants.FILENAME_HABIT)
            if self.habits != nil{
                return self.habits!
            }
            else{
                return NSMutableArray()
            }
        }
    }
    
        
}