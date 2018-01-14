//
//  TouchpointTests.swift
//  TouchpointTests
//
//  Created by user132895 on 1/8/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import XCTest
@testable import Touchpoint

class TouchpointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Contact Class Tests
    
    // Confirm that the Contact initializer returns a Contact object when passed valid parameters
    func testContactInitializationSucceeds() {
        // Name and phone number entered
        let namePhoneContact = Contact.init(name: "Joe", org: "", phone: "604-202-1070", address1: "1704 1st Street", address2: "Vancouver, BC V4G6H8", email: "sally", frequency: "Quarterly", lastTPDate: Date(timeIntervalSinceNow: -5 * 60), birthday: Date(timeIntervalSinceNow: -5 * 60), note: "Great Guy")
        XCTAssertNotNil(namePhoneContact)
    }
    
}
