//
//  Touchpoint.swift
//  Touchpoint
//
//  Created by user132895 on 2/1/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class Touchpoint: NSObject, NSCoding {

    //MARK: Properties
    var contacts: [Contact]
    var date: String
    var notes: String?

    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("touchpoints")

    //MARK: Types
    
    struct PropertyKey {
        static let contacts = "contacts"
        static let date = "date"
        static let notes = "notes"
    }
    
    //MARK: Initialization
    
    init?(contacts: [Contact], date: String?, notes: String?) {
        
        // Initialize stored properties
        self.contacts = contacts
        self.date = date!
        self.notes = notes
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(contacts, forKey: PropertyKey.contacts)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(notes, forKey: PropertyKey.notes)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let contacts = aDecoder.decodeObject(forKey: PropertyKey.contacts) as? [Contact]
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String
    
        self.init(contacts: contacts!, date: date, notes: notes)
        
    }
    
}
