//
//  AddOperatorViewController.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/11/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
import Material

class AddOperatorViewController: UIViewController, UITextFieldDelegate {

    private var Operators:NSMutableArray!
    var isPunishment:Bool = true
   
    @IBOutlet weak var txtOperatorField: TextField!
    override func viewDidLoad() {
        
    self.prepareHabitTextField()
    super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        txtOperatorField.becomeFirstResponder()
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (self.isMovingFromParentViewController() || self.isBeingDismissed()) {
            
            
            if(txtOperatorField.text?.isEmpty != true)
            {
                let opData:OperatorData =  OperatorData()
                let ops:NSMutableArray = isPunishment ? opData.retrievePunishments() : opData.retrieveRewards()
                ops.addObject(txtOperatorField.text!)
                let saveSucces = isPunishment ? opData.savePunishments(ops) : opData.saveRewards(ops)
                print(saveSucces)
                
            }
        }
    }
    
    func addNewOperator(){
        if(isPunishment){
            //Add New Punishment To List
        }
        else{
            // Add New Reward
        }
    }
    
    func prepareHabitTextField()
    {
        
       self.txtOperatorField.delegate = self;
       self.txtOperatorField.returnKeyType = UIReturnKeyType.Done
       self.txtOperatorField.font = UIFont(name: Constants.FONT_LIGHT, size: 35)
       self.txtOperatorField.placeholder = isPunishment ? "My Punishment" : "My Reward"
        self.txtOperatorField.clearButtonMode = .WhileEditing
        
    }
    
  /*
    - (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    }
 */
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.txtOperatorField.resignFirstResponder()
    }
    
    
    func retrieveOperators()->NSMutableArray{
        let operatorData:OperatorData = OperatorData()
        self.Operators = isPunishment ? operatorData.retrievePunishments() : operatorData.retrieveRewards()
        return self.Operators
    }


    
}
