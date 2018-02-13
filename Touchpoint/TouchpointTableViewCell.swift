//
//  TouchpointTableViewCell.swift
//  Touchpoint
//
//  Created by user132895 on 2/12/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class TouchpointTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var TPDateMonth: UITextField!
    @IBOutlet weak var TPDayNumber: UITextField!
    @IBOutlet weak var TPYearNumber: UITextField!
    @IBOutlet weak var contact1TextField: UITextField!
    @IBOutlet weak var contact2TextField: UITextField!
    @IBOutlet weak var contact3TextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
