//
//  HabitTableViewCell.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/5/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import UIKit
import Material
import Font_Awesome_Swift
class HabitTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var btnRefresh: UIButton!
    
    @IBOutlet weak var lblStats: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBAction func btnRefreshAction(sender: AnyObject) {
        delegate?.refreshSelected(self)
    }
    
    @IBAction func btnAddAction(sender: AnyObject) {
        delegate?.addSelected(self)
       // pulseLabel()
    }
    var index:Int!
    var delegate:HabitAdderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func pulseLabel(){
      // self.lblScore.textColor = MaterialColor.blue.base
        UIView.animateWithDuration(1, animations: {
            self.fadeOut()
            }, completion: {
                (value: Bool) in
                self.fadeIn()
        })
    }
    
    
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            self.lblStats.alpha = 1.0

        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            self.lblStats.alpha = 0.0
        })
    }

    

        override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
        // Configure the view for the selected state
    }
    
}

protocol HabitAdderDelegate {

    func addSelected(habitCell:HabitTableViewCell)
    func refreshSelected(habitCell:HabitTableViewCell)

}