//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest
@testable import Tracker

class ArithmeticalPrimitivesTests: XCTestCase {

    private let floatValue: Float = 1
    private let doubleValue: Double = 1
    private let cgValue: CGFloat = 1

    func test_float_zero() {
        XCTAssertEqual(floatValue + .zero, 1)
        XCTAssertEqual(floatValue - .zero, 1)
        XCTAssertEqual(floatValue * .zero, .zero)
        XCTAssertEqual(.zero / floatValue, .zero)
        XCTAssertEqual(floatValue / .zero, .infinity)
    }

    func test_float_multiplications() {
        XCTAssertEqual(floatValue * Double.zero, Float.zero)
        XCTAssertEqual(floatValue * doubleValue, floatValue)
        XCTAssertEqual(doubleValue * Float.zero, .zero)
        XCTAssertEqual(doubleValue * floatValue, Float(doubleValue))
        XCTAssertEqual(floatValue * Double.greatestFiniteMagnitude, Float.infinity)
        XCTAssertEqual(Float.greatestFiniteMagnitude * Double.greatestFiniteMagnitude, Float.infinity)
    }

    func test_float_divisions() {
        XCTAssertEqual(floatValue / Double.zero, Float.infinity)
        XCTAssertEqual(doubleValue / Float.zero, Float.infinity)
        XCTAssertEqual(floatValue / doubleValue, floatValue)
        XCTAssertEqual(doubleValue / floatValue, Float(doubleValue))
    }

    func test_cgfloat_zero() {
        XCTAssertEqual(cgValue + .zero, 1)
        XCTAssertEqual(cgValue - .zero, 1)
        XCTAssertEqual(cgValue * .zero, .zero)
        XCTAssertEqual(.zero / cgValue, .zero)
        XCTAssertEqual(cgValue / .zero, .infinity)
    }

    func test_cgfloat_multiplications() {
        XCTAssertEqual(cgValue * Double.zero, CGFloat.zero)
        XCTAssertEqual(cgValue * doubleValue, cgValue)
        XCTAssertEqual(doubleValue * CGFloat.zero, .zero)
        XCTAssertEqual(doubleValue * cgValue, CGFloat(cgValue))
        XCTAssertEqual(cgValue * Double.greatestFiniteMagnitude, CGFloat.greatestFiniteMagnitude)
        XCTAssertEqual(CGFloat.greatestFiniteMagnitude * Double.greatestFiniteMagnitude, CGFloat.infinity)
    }

    func test_cgfloat_divisions() {
        XCTAssertEqual(cgValue / Double.zero, CGFloat.infinity)
        XCTAssertEqual(doubleValue / CGFloat.zero, CGFloat.infinity)
        XCTAssertEqual(cgValue / doubleValue, cgValue)
        XCTAssertEqual(doubleValue / cgValue, CGFloat(doubleValue))
    }
}
