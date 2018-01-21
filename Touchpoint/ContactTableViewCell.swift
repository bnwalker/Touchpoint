//
//  ContactTableViewCell.swift
//  Touchpoint
//
//  Created by User on 2018-01-14.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orgLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var provStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
