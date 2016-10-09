//
//  AddItemViewController.swift
//  Discipline
//
//  Created by Shannon Layden on 8/28/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
import Material




class AddItemViewController : UIViewController {
    
    @IBOutlet weak var btnSmallPunishment: RaisedButton!
    @IBOutlet weak var btnSmallReward: RaisedButton!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var sprIncrement: UIStepper!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var stpOperatorStepper: UIStepper!
    @IBOutlet weak var btnBadHabitOperator: RaisedButton!
    @IBOutlet weak var btnGoodHabitOperator: RaisedButton!
    var habit:Habit?
    var habitIndex:Int = -1
    var HabitOperator:String = ""
    var HabitMultiplyer:Double = 0
    var isBadHabit = true
    
    @IBOutlet weak var txtHabitText: UITextField!
    @IBOutlet var lblOperator: UILabel!
   // private var txtkHabitText:TextField!
    var habits:NSMutableArray?
   
    @IBAction func stpStep(_ sender: AnyObject) {
        
        let stepper:UIStepper = sender as! UIStepper
        print(stepper.value)
        self.HabitMultiplyer = stepper.value
        let score = String(Int(self.HabitMultiplyer))
        self.lblScore.text = isBadHabit ? "Owe \(score)" : "Receive \(score)"
    }
    
    @IBAction func btnBadHabitAction(_ sender: AnyObject) {
        self.isBadHabit = true
    }
    
    @IBAction func btnGoodHabitAction(_ sender: AnyObject) {
        self.isBadHabit = false
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        
        if(self.HabitOperator.isEmpty && self.habit == nil){
          self.setEmptyState()
        }else
        {
            if self.habit != nil {
                self.txtHabitText.text = self.habit?.Title
                self.stpOperatorStepper.value = (self.habit?.HabitOperatorSize)!
                self.HabitOperator = (self.habit?.HabitOperator)!
                self.setOperator()
                
            }
            self.setEditState()
            
        }
        
    }
    
    func setEmptyState(){
        self.txtHabitText.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.txtHabitText.placeholder = "My Habit"
        self.prepareBadOperatorButton()
        self.prepareGoodOperatorButton()
        self.stpOperatorStepper.isHidden = true
        self.lblOperator.isHidden = true
        self.lblScore.isHidden = true
        self.btnSmallReward.isHidden = true
        self.btnSmallPunishment.isHidden = true
    }
    
    func setEditState(){
        self.HabitMultiplyer = self.stpOperatorStepper.value
        self.lblOperator.text  = self.HabitOperator
        //self.txtHabitText.placeholder = ""
        self.setOperator()
        self.txtHabitText.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.prepareStepper()
       // self.prepareOperatorLabel()
        self.prepareHabitTextField()
        self.hideButtons()
        self.stpOperatorStepper.isHidden = false
        self.lblOperator.isHidden = false
        self.lblScore.isHidden = false
        self.btnSmallPunishment.isHidden = false
        self.btnSmallReward.isHidden = false
        prepareSmallButtons()
        
   
     }
    
    func setOperator(){
        self.lblScore.isHidden = false
        self.lblScore.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.lblScore.text = String(self.HabitMultiplyer)
        self.lblScore.text = self.isBadHabit ? "Owe \(String(Int(self.stpOperatorStepper.value)))" : "Receive \(String(Int(self.stpOperatorStepper.value)))"
        self.lblScore.adjustsFontSizeToFitWidth = true
        self.lblOperator.isHidden = false
        self.lblOperator.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
        self.lblOperator.text = StringFixer.MakeOperatorPlural(self.HabitOperator)

    }
    
    func hideButtons()
    {
        self.btnBadHabitOperator.isHidden = true
        self.btnGoodHabitOperator.isHidden = true
    }
    
    func prepareStepper()
    {
       /* let stepper:GMStepper = GMStepper()
        self.view.addSubview(stepper)
 */
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // txtHabitText.becomeFirstResponder()
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
        self.lblOperator.adjustsFontSizeToFitWidth = true
    }
    
    func prepareSmallButtons()
    {
        self.btnSmallPunishment.backgroundColor = Color.red.base
        self.btnSmallPunishment.pulseColor = Color.red.accent4
        self.btnSmallReward.backgroundColor = Color.green.base
        self.btnSmallReward.pulseColor = Color.green.accent4
        self.btnSmallReward.titleLabel?.text = ""
        self.btnSmallPunishment.titleLabel?.text = ""
    }
    
    func prepareBadOperatorButton()
    {
        Fonter.fixbutton(self.btnBadHabitOperator)
 //   self.btnBadHabitOperator.titleLabel?.font = Fontfix.setlabelfont(UILabel())
    self.btnBadHabitOperator.titleLabel?.font = UIFont(name: Constants.FONT_REG, size: 20)!
    self.btnBadHabitOperator.setTitle("Punish", for: UIControlState())
    self.btnBadHabitOperator.setTitleColor(Color.white, for: UIControlState())
    self.btnBadHabitOperator.pulseColor = Color.red.accent4
    self.btnBadHabitOperator.backgroundColor = Color.red.base

    }
    
    func prepareGoodOperatorButton()
    {
        Fonter.fixbutton(self.btnGoodHabitOperator)
        self.btnGoodHabitOperator.titleLabel?.font = UIFont(name: Constants.FONT_REG, size: 20)!
        self.btnGoodHabitOperator.setTitle("Reward", for: UIControlState())
        self.btnGoodHabitOperator.setTitleColor(Color.white, for: UIControlState())
        self.btnGoodHabitOperator.pulseColor = Color.green.accent4
        self.btnGoodHabitOperator.backgroundColor = Color.green.base
        self.btnGoodHabitOperator.systemLayoutSizeFitting(CGSize(width: 70,height: 20))

    }
    
   func prepareHabitTextField()
    {
    self.txtHabitText.clearButtonMode = .whileEditing
        self.txtHabitText.adjustsFontSizeToFitWidth = true
    }
    
    
    
    @IBAction func save(_ sender: AnyObject) {
        //let still allows mutable array to be changed. Just not reassigned.
        if((txtHabitText.text?.isEmpty)!){
            raiseEmptyTextError(errorMessage: Constants.ERROR_REQUIRED_HABIT_TITLE)
        }
        else if((lblScore.text?.isEmpty)!){
            raiseEmptyTextError(errorMessage: Constants.ERROR_REQUIRED_OPERATOR)
        }
        else if(lblOperator.text?.isEmpty)!{
            raiseEmptyTextError(errorMessage: Constants.ERROR_REQUIRED_OPERATOR)
            
        }
        else{
        let habit = txtHabitText.text
        let Operator:String = StringFixer.MakeOperatorPlural(self.HabitOperator.lowercased())
            if(self.habitIndex == -1){
             self.habit = Habit(title: habit!, habitOperatorSize: self.HabitMultiplyer, habitoperator: Operator, isbadHabit: self.isBadHabit)
                  self.habits!.add(self.habit!)
            }else{
                self.habit?.Title = habit!
                self.habit?.HabitOperatorSize = self.HabitMultiplyer
                self.habits?.removeObject(at: self.habitIndex)
                self.habits!.insert(self.habit!, at: self.habitIndex)
            }
            
        
            
       
            let habitData:HabitData = HabitData()
            let success =  habitData.saveArrayToFile(self.habits!, FileName: Constants.FILENAME_HABIT)
            print(success)
            btnCancel.title = "Done"
            self.dismiss(animated: true) {
                //
            }
        }
  
      


    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        
        
        self.dismiss(animated: true) {
            //
        }
        
    }
    
    func raiseEmptyTextError(errorMessage:String){
        // create the alert
        let alert = UIAlertController(title: "Oops", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.destination is UINavigationController)
       {
        let navController:UINavigationController = segue.destination as! UINavigationController
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
