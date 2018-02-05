//
//  TouchpointTableViewCell.swift
//  Touchpoint
//
//  Created by user132895 on 2/1/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class TouchpointTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var orgTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
