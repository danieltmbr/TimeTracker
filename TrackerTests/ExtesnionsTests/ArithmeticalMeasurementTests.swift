//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest

class ArithmeticalMeasurementTests: XCTestCase {

    func test_measurement_zero() {
        XCTAssertEqual(Measurement<UnitLength>.zero, Measurement(value: 0, unit: UnitLength.baseUnit()))
    }
}
