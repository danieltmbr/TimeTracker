//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Daniel Tombor on 2018. 08. 04..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest
@testable import Tracker

class TrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }

    func testPerformace_magnitudesSum() {
        // This is an example of a performance test case.
        let doubles =  Array(repeating: DoubleItem(magnitude: 12), count: 1000000)
        self.measure {
            _ = doubles.magnitudes.sum()
        }
    }

    func testPerformace_reduceSum() {
        // This is an example of a performance test case.
        let doubles =  Array(repeating: DoubleItem(magnitude: 12), count: 1000000)
        self.measure {
            _ = doubles.reduce(Double.zero) { return $0 + $1.magnitude }
        }
    }
}

struct DoubleItem: TrackItem {

    var magnitude: Double
}
