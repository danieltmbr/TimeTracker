//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest
@testable import Tracker

class ArithmeticalArrayTests: XCTestCase {

    private let arithmeticals = [1,3,5,7,9,2,4,6,8,2,11,2].arithmeticals
    private let hugeNumberOfArithmeticals = Array<Double>(repeating: 12345.56, count: 50000).arithmeticals

    func test_sum() {
        XCTAssertEqual(arithmeticals.sum(), 60.arithmetical)
    }

    func test_sum_empty() {
        XCTAssertEqual([].arithmeticals.sum(), .zero)
    }

    func test_mean() {
        XCTAssertEqual(arithmeticals.mean(), 5.arithmetical)
    }

    func test_mean_empty() {
        XCTAssertEqual([].arithmeticals.mean(), .zero)
    }

    func test_median_evenCount() {
        XCTAssertEqual(arithmeticals.median(), 4.5.arithmetical)
    }

    func test_median_oddCount() {
        let arithmeticals = [6,7,4,3,5].arithmeticals
        XCTAssertEqual(arithmeticals.median(), 5.arithmetical)
    }

    func test_median_empty() {
        XCTAssertNil([].arithmeticals.median())
    }

    func test_range() {
        XCTAssertEqual(arithmeticals.range(), 10.arithmetical)
    }

    func test_range_empty() {
        XCTAssertNil([].arithmeticals.range())
    }

    func test_mode() {
        XCTAssertEqual(arithmeticals.mode(), 2.arithmetical)
    }

    func test_mode_empty() {
        XCTAssertNil([].arithmeticals.mode())
    }

    // MARK: - Performance tests

    func test_sum_performance() {
        measure { _ = hugeNumberOfArithmeticals.sum() }
    }

    func test_mean_performance() {
        measure { _ = hugeNumberOfArithmeticals.mean() }
    }

    func test_median_even_performance() {
        measure { _ = hugeNumberOfArithmeticals.median() }
    }

    func test_range_performance() {
        measure { _ = hugeNumberOfArithmeticals.range() }
    }

    func test_mode_performance() {
        measure { _ = hugeNumberOfArithmeticals.mode() }
    }
}

private struct MockArithmetical: Arithmetical, Hashable {

    var value: Double

    static var zero: MockArithmetical = MockArithmetical(value: Double.zero)

    static func + (lhs: MockArithmetical, rhs: MockArithmetical) -> MockArithmetical {
        return MockArithmetical(value: lhs.value + rhs.value)
    }

    static func - (lhs: MockArithmetical, rhs: MockArithmetical) -> MockArithmetical {
        return MockArithmetical(value: lhs.value - rhs.value)
    }

    static func * (lhs: MockArithmetical, rhs: Double) -> MockArithmetical {
        return MockArithmetical(value: lhs.value * rhs)
    }

    static func * (lhs: Double, rhs: MockArithmetical) -> MockArithmetical {
        return MockArithmetical(value: rhs.value * lhs)
    }

    static func / (lhs: MockArithmetical, rhs: Double) -> MockArithmetical {
        return MockArithmetical(value: lhs.value / rhs)
    }

    static func / (lhs: Double, rhs: MockArithmetical) -> MockArithmetical {
        return MockArithmetical(value: lhs / rhs.value)
    }

    static func < (lhs: MockArithmetical, rhs: MockArithmetical) -> Bool {
        return lhs.value < rhs.value
    }
}

private extension Array where Element == Double {
    var arithmeticals: [MockArithmetical] {
        return map { MockArithmetical(value: $0) }
    }
}

private extension Double {
    var arithmetical: MockArithmetical { return MockArithmetical(value: self) }
}
