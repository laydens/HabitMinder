//
//  AddOperatorViewController.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/11/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
import Material

class AddOperatorViewController: UIViewController {

    private var operators:NSMutableArray!
    private var txtOperatorText:TextField!
   
    override func viewDidLoad() {
    
    self.prepareHabitTextField()
    super.viewDidLoad()
    
    self.view.addSubview(txtOperatorText)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        txtOperatorText.becomeFirstResponder()
        super.viewDidAppear(true)
    }
    
    
    func prepareHabitTextField()
    {
        
        self.txtOperatorText = TextField()
        self.txtOperatorText.placeholder = "hello there"
        self.txtOperatorText.clearButtonMode = .WhileEditing
        
    }
    
    func retrieveOperators()->NSMutableArray{
        if self.operators != nil {
            return self.operators!
        }
        else{
            let habitData:HabitData = HabitData()
            self.operators = habitData.retrieveItemsFromFile(Constants.FILENAME_OPERATORS)
            if self.operators != nil{
                return self.operators!
            }
            else{
                return Constants.OPERATORS
            }
        }
    }


    
}
