//
//  TrackItemTests.swift
//  TrackerTests
//
//  Created by Daniel Tombor on 2018. 09. 01..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest

class TrackItemTests: XCTestCase {

    func test_comperatorOperators() {
        let zero = MockTrackItem(magnitude: 0)
        let small = MockTrackItem(magnitude: 0)
        let big = MockTrackItem(magnitude: 1)

        XCTAssertTrue(zero <= zero)
        XCTAssertTrue(zero >= zero)
        XCTAssertFalse(zero < zero)
        XCTAssertFalse(zero > zero)

        XCTAssertTrue(small < big)
        XCTAssertTrue(small <= big)
        XCTAssertFalse(small > big)
        XCTAssertFalse(small >= big)

        XCTAssertFalse(big < small)
        XCTAssertFalse(big <= small)
        XCTAssertTrue(big > small)
        XCTAssertTrue(big >= small)

        XCTAssertTrue(small <= zero)
        XCTAssertTrue(small >= zero)
        XCTAssertTrue(zero <= small)
        XCTAssertTrue(zero >= small)
    }
}
