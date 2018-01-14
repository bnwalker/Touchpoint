//
//  Contact.swift
//  Touchpoint
//
//  Created by User on 2018-01-14.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class Contact {
    
    //MARK: Properties
    
    var name: String
    var org: String?
    var phone: String?
    var address1: String?
    var address2: String?
    var email: String?
    var frequency: String
    var lastTPDate: Date?
    var birthday: Date?
    var note: String?

    //MARK: Initialization
    
    init?(name: String, org: String, phone: String, address1: String, address2: String, email: String, frequency: String, lastTPDate: Date, birthday: Date, note: String) {
        
        // Initialization should fail if name is empty
        if name.isEmpty {
            return nil
        }
        
        // Initiazation should fail if frequency is any value other than the established options
        if !(frequency == "Monthy" || frequency == "Quarterly" || frequency == "Semiannually") {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.org = org
        self.phone = phone
        self.address1 = address1
        self.address2 = address2
        self.email = email
        self.frequency = frequency
        self.lastTPDate = lastTPDate
        self.birthday = birthday
        self.note = note
    }
    
}

