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
    
  
    @IBOutlet weak var sprIncrement: UIStepper!
  
   
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnBadHabitOperator: RaisedButton!
    @IBOutlet weak var btnGoodHabitOperator: RaisedButton!
    @IBOutlet weak var badHabitText: UITextField!
    var HabitOperator:String = ""
    var HabitMultiplyer:Int = 1
    var isBadHabit = true
    
    @IBOutlet weak var txtHabitText: TextField!
    @IBOutlet weak var lblOperator: MaterialLabel!
   // private var txtkHabitText:TextField!
    var json:JSON = []
    var habits:NSMutableArray?
   
    @IBAction func stpStep(sender: AnyObject) {
        
        let stepper:UIStepper = sender as! UIStepper
        print(stepper.value)
    }
    
  
    
    @IBAction func btnBadHabitAction(sender: AnyObject) {
        
    }
    
    @IBAction func btnGoodHabitAction(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        
        self.prepareHabitTextField()
        self.prepareBadOperatorButton()
        self.prepareGoodOperatorButton()
        self.prepareStepper()
        
       // self.view.layout(txtHabitText).top(100).horizontally(left: 40, right: 40)
       

       // self.view.layout(btnOperator).top(txtHabitText).horizontally(txtHabitText)
      //  self.view.addSubview(txtHabitText)
     //   self.view.addSubview(btnGoodHabitOperator)
     //   self.view.addSubview(btnBadHabitOperator)
        super.viewDidLoad()
    }
    
  
    override func viewWillAppear(animated: Bool) {
        if(!self.HabitOperator.isEmpty){
           
          if((lblOperator == nil))
          {
            self.lblOperator = MaterialLabel()
            self.view.addSubview(lblOperator)
          }
            self.prepareOperatorLabel()
        }
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
      //  self.lblOperator.font = UIFont(name: Constants.FONT_LIGHT, size: 16)
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
        self.btnBadHabitOperator.setTitle("Punish", forState: .Normal)
    self.btnBadHabitOperator.setTitleColor(MaterialColor.white, forState: .Normal)
    self.btnBadHabitOperator.pulseColor = MaterialColor.orange.accent4
    self.btnBadHabitOperator.backgroundColor = MaterialColor.orange.base

    }
    
    func prepareGoodOperatorButton()
    {
        //self.btnGoodHabitOperator = RaisedButton()
        Fonter.fixbutton(self.btnGoodHabitOperator)
        self.btnGoodHabitOperator.setTitle("Reward", forState: .Normal)
        self.btnGoodHabitOperator.setTitleColor(MaterialColor.white, forState: .Normal)
        self.btnGoodHabitOperator.pulseColor = MaterialColor.green.accent4
        self.btnGoodHabitOperator.backgroundColor = MaterialColor.green.base
        self.btnGoodHabitOperator.systemLayoutSizeFittingSize(CGSize(width: 70,height: 20))

    }
    
   func prepareHabitTextField()
    {
    
    self.txtHabitText.clearButtonMode = .WhileEditing
   // Fonter.fixlabel(self.txtHabitText)
    
    }
    
    
    
    @IBAction func save(sender: AnyObject) {
        //let still allows mutable array to be changed. Just not reassigned.
        
        if let habit = txtHabitText.text where !habit.isEmpty{
            let Operator:String = StringFixer.MakeOperatorPlural(self.HabitOperator.lowercaseString)
         let newHabit:Habit = Habit(title: habit, habitOperatorSize: 10, habitoperator: Operator)
         self.habits!.addObject(newHabit)
         let habitData:HabitData = HabitData()
         habitData.saveHabitsToFile(self.habits!, FileName: Constants.FILENAME_HABIT)
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