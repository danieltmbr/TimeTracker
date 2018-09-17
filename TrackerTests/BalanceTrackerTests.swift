//  Copyright © 2018. danieltmbr. All rights reserved.
//

@testable import Tracker
import XCTest

class BalanceTrackerTests: XCTestCase {

    private let drains: [MockTrackItem] = [1, 2, 3].trackItems
    private let sources: [MockTrackItem] = [18].trackItems

    func test_balanceIsCorrect() {
        let balanceTracker = MockBalanceTracker(items: drains, sources: sources)
        let balance = DefaultBalance(sources: sources, drains: drains)

        XCTAssertEqual(balanceTracker.balance(), balance)
    }

    func test_balanceValueIsCorrect() {
        let balanceTracker = MockBalanceTracker(items: drains, sources: sources)
        let balance = DefaultBalance(sources: sources, drains: drains)

        XCTAssertEqual(balanceTracker.balanceValue(), balance.difference)
    }
}

private struct MockBalanceTracker: BalanceTracker {
    var items: [MockTrackItem]
    var sources: [MockTrackItem]
}
