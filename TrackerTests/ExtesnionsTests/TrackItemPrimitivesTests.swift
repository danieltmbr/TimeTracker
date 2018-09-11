//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest

class TrackItemPrimitivesTests: XCTestCase {

    func test_double() {
        let positive: Double = 5.5
        let negative: Double = -2.1

        XCTAssertEqual(positive.magnitude, 5.5)
        XCTAssertEqual(negative.magnitude, 2.1)
    }

    func test_cgfloat() {
        let positive: CGFloat = 5.5
        let negative: CGFloat = -2.1

        XCTAssertEqual(positive.magnitude, 5.5)
        XCTAssertEqual(negative.magnitude, 2.1)
    }

    func test_float() {
        let positive: Float = 5.5
        let negative: Float = -2.1

        XCTAssertEqual(positive.magnitude, 5.5)
        XCTAssertEqual(negative.magnitude, 2.1)
    }
}
