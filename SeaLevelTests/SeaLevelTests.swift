//
//  SeaLevelTests.swift
//  SeaLevelTests
//
//  Created by Reed Wilson on 9/17/15.
//  Copyright © 2015 Reed Wilson. All rights reserved.
//

import XCTest
import CoreLocation
@testable import SeaLevel

class SeaLevelTests: XCTestCase {
    
    var seaLevelFinder: SealevelFinder?
    
    override func setUp() {
        super.setUp()
        seaLevelFinder = SealevelFinder()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAtSeaLevel() {
        // test location distance (altitude)
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(16), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertFalse(result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-16), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertFalse(result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(15), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertTrue(result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-15), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertTrue(result)
        }
        
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(14), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertTrue(result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-14), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertTrue(result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(4), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertTrue(result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-4), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertTrue(result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(0), verticalAccuracy: CLLocationAccuracy(9)) {
            XCTAssertTrue(result)
        }
        
        // test location accuracy
        XCTAssertTrue(seaLevelFinder!.atSeaLevel(CLLocationDistance(0), verticalAccuracy: CLLocationAccuracy(-1)) == nil)
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(0), verticalAccuracy: CLLocationAccuracy(10)) {
            XCTAssertTrue(result)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
