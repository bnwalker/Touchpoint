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
    var addressStreet: String?
    var addressCity: String?
    var addressProvState: String?
    var addressCode: String?
    var email: String?
    var frequency: String
    var lastTPDate: String?
    var birthday: String?
    var note: String?

    //MARK: Initialization
    
    init?(name: String, org: String?, phone: String?, addressStreet: String?, addressCity: String?, addressProvState: String?, addressCode: String?, email: String?, frequency: String, lastTPDate: String?, birthday: String?, note: String?) {
        
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
        self.addressStreet = addressStreet
        self.addressCity = addressCity
        self.addressProvState = addressProvState
        self.addressCode = addressCode
        self.email = email
        self.frequency = frequency
        self.lastTPDate = lastTPDate
        self.birthday = birthday
        self.note = note
    }
    
}

