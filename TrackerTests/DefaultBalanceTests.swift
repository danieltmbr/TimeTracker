//  Copyright © 2018. danieltmbr. All rights reserved.
//

@testable import Tracker
import XCTest

final class DefaultBalanceTests: XCTestCase {

    private let drains: [MockTrackItem] = [1, 2, 3].trackItems
    private let sources: [MockTrackItem] = [18].trackItems

    func test_initalizationWithArrays() {
        let balance = DefaultBalance(sources: sources, drains: drains)

        XCTAssertEqual(balance.drain, drains.sum())
        XCTAssertEqual(balance.source, sources.sum())
    }

    func test_initalizationWithValues() {
        let balance = DefaultBalance(source: sources.sum(), drain: drains.sum())

        XCTAssertEqual(balance.drain, drains.sum())
        XCTAssertEqual(balance.source, sources.sum())
    }

    func test_defaultDifferenceIsCorrect() {
        let balance = DefaultBalance(sources: sources, drains: drains)

        XCTAssertEqual(balance.difference, sources.sum() - drains.sum())
    }
}
