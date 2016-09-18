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
    
    @IBOutlet weak var btnRefresh: UIButton!
    
    @IBOutlet weak var lblStats: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBAction func btnRefreshAction(sender: AnyObject) {
        delegate?.refreshSelected(self)
    }
    
    @IBAction func btnAddAction(sender: AnyObject) {
        delegate?.addSelected(self)
    }
    var index:Int!
    var delegate:HabitAdderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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