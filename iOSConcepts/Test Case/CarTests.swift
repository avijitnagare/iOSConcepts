//
//  CarTests.swift
//  iOSConceptsTests
//
//  Created by Avijit Nagare on 24/04/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import XCTest
@testable import iOSConcepts

class CarTests: XCTestCase {

    var ferrari: Car!
    var jeep: Car!
    var honda: Car!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        ferrari = Car(type: .Sport, transmission: .Drive)
        jeep = Car(type: .OffRoad, transmission: .Drive)
        honda = Car(type: .Economy, transmission: .Park)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        ferrari = nil
        jeep = nil
        honda = nil
    }

    func testSportFasterThanJeep() {
        let minute = 60
        
        //1 start ferrari
        ferrari.start(minute: minute)
        
        //2. start jeep
        jeep.start(minute: minute)
        
        //test it
        XCTAssertTrue(ferrari.miles > jeep.miles)
        
        
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

}
