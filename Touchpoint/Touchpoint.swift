//
//  Touchpoint.swift
//  Touchpoint
//
//  Created by user132895 on 2/6/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit
import os.log

class Touchpoint: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name1: String
    var org1: String?
    var name2: String?
    var org2: String?
    var name3: String?
    var org3: String?
    var name4: String?
    var org4: String?
    var touchpointDate: String?
    var notes: String?
    var goals: String?
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("touchpoints")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name1 = "name1"
        static let org1 = "org1"
        static let name2 = "name2"
        static let org2 = "org2"
        static let name3 = "name3"
        static let org3 = "org3"
        static let name4 = "name4"
        static let org4 = "org4"
        static let touchpointDate = "touchpointDate"
        static let notes = "notes"
        static let goals = "goals"
        static let photo = "photo"
    }
    
    //MARK: Initialization
    
    init?(name1: String, org1: String?, name2: String?, org2: String?, name3: String?, org3: String?, name4: String?, org4: String?, touchpointDate: String?, notes: String?, goals: String?, photo: UIImage?) {
        
        // Initialization should fail if name is empty
        if name1.isEmpty {
            return nil
        }
        
        // Initialize stored properties
        self.name1 = name1
        self.org1 = org1
        self.name2 = name2
        self.org2 = org2
        self.name3 = name3
        self.org3 = org3
        self.name4 = name4
        self.org4 = org4
        self.touchpointDate = touchpointDate
        self.notes = notes
        self.goals = goals
        self.photo = photo
     }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name1, forKey: PropertyKey.name1)
        aCoder.encode(org1, forKey: PropertyKey.org1)
        aCoder.encode(name2, forKey: PropertyKey.name2)
        aCoder.encode(org2, forKey: PropertyKey.org2)
        aCoder.encode(name3, forKey: PropertyKey.name3)
        aCoder.encode(org3, forKey: PropertyKey.org3)
        aCoder.encode(name4, forKey: PropertyKey.name4)
        aCoder.encode(org4, forKey: PropertyKey.org4)
        aCoder.encode(touchpointDate, forKey: PropertyKey.touchpointDate)
        aCoder.encode(notes, forKey: PropertyKey.notes)
        aCoder.encode(goals, forKey: PropertyKey.goals)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        // The name1 field is required.  If we cannot decode a name1 string, the initializer should fail.
        guard let name1 = aDecoder.decodeObject(forKey: PropertyKey.name1) as? String else {
            os_log("Unable to decode the name1 for a Touchpoint object", log: OSLog.default, type: .debug)
            return nil
        }
        let org1 = aDecoder.decodeObject(forKey: PropertyKey.org1) as? String
        let name2 = aDecoder.decodeObject(forKey: PropertyKey.name2) as? String
        let org2 = aDecoder.decodeObject(forKey: PropertyKey.org2) as? String
        let name3 = aDecoder.decodeObject(forKey: PropertyKey.name3) as? String
        let org3 = aDecoder.decodeObject(forKey: PropertyKey.org3) as? String
        let name4 = aDecoder.decodeObject(forKey: PropertyKey.name4) as? String
        let org4 = aDecoder.decodeObject(forKey: PropertyKey.org4) as? String
        let touchpointDate = aDecoder.decodeObject(forKey: PropertyKey.touchpointDate) as? String
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String
        let goals = aDecoder.decodeObject(forKey: PropertyKey.goals) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        // Must call designated initializer
        self.init(name1: name1, org1: org1, name2: name2, org2: org2, name3: name3, org3: org3, name4: name4, org4: org4, touchpointDate: touchpointDate, notes: notes, goals: goals, photo: photo)
    }
}


