//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest

class TrackItemMeasurementsTests: XCTestCase {

    func test_measurement_magnitude() {
        let positive = Measurement(value: 5, unit: UnitLength.meters)
        let negative = Measurement(value: 5, unit: UnitLength.meters)

        XCTAssertEqual(positive.magnitude, Measurement(value: 5, unit: UnitLength.baseUnit()))
        XCTAssertEqual(negative.magnitude, Measurement(value: 5, unit: UnitLength.baseUnit()))
    }
}
