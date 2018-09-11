//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest

class TracItemArrayTests: XCTestCase {

    let items = [1,3,5,7,9,2,4,6,8,2,11,2].trackItems
    let hugeNumberOfItems = Array<Double>(repeating: 12345.56, count: 50000).trackItems

    func test_magnitudes() {
        XCTAssertEqual(items.magnitudes, [1,3,5,7,9,2,4,6,8,2,11,2])
    }

    func test_sum() {
        XCTAssertEqual(items.sum(), 60)
    }

    func test_sum_empty() {
        XCTAssertEqual([].trackItems.sum(), .zero)
    }

    func test_mean() {
        XCTAssertEqual(items.mean(), 5)
    }

    func test_mean_empty() {
        XCTAssertEqual([].trackItems.mean(), .zero)
    }

    func test_median_evenCount() {
        XCTAssertEqual(items.median(), 4.5)
    }

    func test_median_oddCount() {
        let items = [6,7,4,3,5].trackItems
        XCTAssertEqual(items.median(), 5)
    }

    func test_median_empty() {
        XCTAssertNil([].trackItems.median())
    }

    func test_range() {
        XCTAssertEqual(items.range(), 10)
    }

    func test_range_empty() {
        XCTAssertNil([].trackItems.range())
    }

    func test_mode() {
        XCTAssertEqual(items.mode(), 2)
    }

    func test_mode_empty() {
        XCTAssertNil([].trackItems.mode())
    }

    // MARK: - Performance tests

    func test_sum_performance() {
        measure { _ = hugeNumberOfItems.sum() }
    }

    func test_mean_performance() {
        measure { _ = hugeNumberOfItems.mean() }
    }

    func test_median_even_performance() {
        measure { _ = hugeNumberOfItems.median() }
    }

    func test_range_performance() {
        measure { _ = hugeNumberOfItems.range() }
    }

    func test_mode_performance() {
       measure { _ = hugeNumberOfItems.mode() }
    }
}
