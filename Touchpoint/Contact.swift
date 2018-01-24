//
//  Contact.swift
//  Touchpoint
//
//  Created by User on 2018-01-14.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit
import os.log

class Contact: NSObject, NSCoding {
    
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

    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("contacts")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let org = "org"
        static let phone = "phone"
        static let addressStreet = "addressStreet"
        static let addressCity = "AddressCity"
        static let addressProvState = "AddressProvState"
        static let addressCode = "AddressCode"
        static let email = "email"
        static let frequency = "frequency"
        static let lastTPDate = "lastTPDate"
        static let birthday = "birthday"
        static let note = "note"
    }
    
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
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(org, forKey: PropertyKey.org)
        aCoder.encode(phone, forKey: PropertyKey.phone)
        aCoder.encode(addressStreet, forKey: PropertyKey.addressStreet)
        aCoder.encode(addressCity, forKey: PropertyKey.addressCity)
        aCoder.encode(addressProvState, forKey: PropertyKey.addressProvState)
        aCoder.encode(addressCode, forKey: PropertyKey.addressCode)
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(frequency, forKey: PropertyKey.frequency)
        aCoder.encode(lastTPDate, forKey: PropertyKey.lastTPDate)
        aCoder.encode(birthday, forKey: PropertyKey.birthday)
        aCoder.encode(note, forKey: PropertyKey.note)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        // The name is required.  If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Contact object", log: OSLog.default, type: .debug)
            return nil
        }
        let org = aDecoder.decodeObject(forKey: PropertyKey.org) as? String
        let phone = aDecoder.decodeObject(forKey: PropertyKey.phone) as? String
        let addressStreet = aDecoder.decodeObject(forKey: PropertyKey.addressStreet) as? String
        let addressCity = aDecoder.decodeObject(forKey: PropertyKey.addressCity) as? String
        let addressProvState = aDecoder.decodeObject(forKey: PropertyKey.addressProvState) as? String
        let addressCode = aDecoder.decodeObject(forKey: PropertyKey.addressCode) as? String
        let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String
        let frequency = aDecoder.decodeObject(forKey: PropertyKey.frequency) as? String
        let lastTPDate = aDecoder.decodeObject(forKey: PropertyKey.lastTPDate) as? String
        let birthday = aDecoder.decodeObject(forKey: PropertyKey.birthday) as? String
        let note = aDecoder.decodeObject(forKey: PropertyKey.note) as? String
        
        // Must call designated initializer
        self.init(name: name, org: org, phone: phone, addressStreet: addressStreet, addressCity: addressCity, addressProvState: addressProvState, addressCode: addressCode, email: email, frequency: frequency!, lastTPDate: lastTPDate, birthday: birthday, note: note)
    }
}

