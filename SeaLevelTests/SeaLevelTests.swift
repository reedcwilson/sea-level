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

    func testNegativeVerticalAccuracyReturnsNil() {
        var result = seaLevelFinder!.atSeaLevel(CLLocationDistance(0), verticalAccuracy: CLLocationAccuracy(-1), padding: CLLocationDistance(15))
        XCTAssertNil(result)

        result = seaLevelFinder!.atSeaLevel(CLLocationDistance(16), verticalAccuracy: CLLocationAccuracy(-0.5), padding: CLLocationDistance(15))
        XCTAssertNil(result)
    }
    
    func testAtSeaLevel() {
        // test location distance (altitude)
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(16), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Above, result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-16), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Below, result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(15), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-15), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
        
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(14), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-14), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(4), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(-4), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(0), verticalAccuracy: CLLocationAccuracy(9), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
        
        // test location accuracy
        XCTAssertEqual(nil, seaLevelFinder!.atSeaLevel(CLLocationDistance(0), verticalAccuracy: CLLocationAccuracy(-1), padding: CLLocationDistance(15)))
        if let result = seaLevelFinder!.atSeaLevel(CLLocationDistance(0), verticalAccuracy: CLLocationAccuracy(10), padding: CLLocationDistance(15)) {
            XCTAssertEqual(AtSeaLevel.Yes, result)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
