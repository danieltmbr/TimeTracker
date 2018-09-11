//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest
@testable import Tracker

class GroupBalanceTrackerTests: XCTestCase {

    private let firstInterval = DateInterval(start: Date(), duration: .day)
    private var secondInterval: DateInterval {
        return DateInterval(start: firstInterval.end, duration: .day)
    }
    private var thirdInterval: DateInterval {
        return DateInterval(start: secondInterval.end, duration: .day)
    }

    // MARK: Tests

    func test_dateGroup_allSourcesAreCorrect() {
        let (_, _, _, tracker) = setupGroupBalanceTracker()

        let allSources = tracker.allSources.sorted()
        XCTAssertEqual(allSources, [4,5,6,7,8,9].trackItems)
    }

    func test_dateGroup_noSourcesAreReturnedForOutOfRangeDateIntervals() {
        let (_, secondDate, thirdDate, tracker) = setupGroupBalanceTracker()

        let earlierInterval = DateInterval(start: Date(timeInterval: -.day, since: secondDate), duration: .hour)
        XCTAssertEqual(tracker.sources(in: earlierInterval).count, 0)

        let laterInterval = DateInterval(start: Date(timeInterval: .day, since: thirdDate), duration: .hour)
        XCTAssertEqual(tracker.sources(in: laterInterval).count, 0)
    }

    func test_dateGroup_correctSourcesAreReturnedForDateIntervals() {
        let (_, secondDate, thirdDate, tracker) = setupGroupBalanceTracker()

        let intervalContainingSecondDate = DateInterval(start: Date(timeInterval: 0, since: secondDate), duration: .hour)
        XCTAssertEqual(tracker.sources(in: intervalContainingSecondDate), [4,5,6].trackItems)

        let intervalContainingThirdDate = DateInterval(start: Date(timeInterval: 0, since: thirdDate), duration: .hour)
        XCTAssertEqual(tracker.sources(in: intervalContainingThirdDate), [7,8,9].trackItems)

        let intervalContainingBothDates = DateInterval(start: Date(timeInterval: 0, since: secondDate), duration: .day)
        XCTAssertEqual(tracker.sources(in: intervalContainingBothDates).sorted(), [4,5,6,7,8,9].trackItems)
    }

    func test_dateGroup_balanceIsCorrectForGroup() {
        let (firstDate, secondDate, thirdDate, tracker) = setupGroupBalanceTracker()

        // Test balance containing only drain items
        let firstBalance = DefaultBalance(sources: [].trackItems, drains: [1,2,3].trackItems)
        XCTAssertEqual(tracker.balance(for: firstDate), firstBalance)

        // Test balance containing both source & drain items
        let secondBalance = DefaultBalance(sources: [4,5,6].trackItems, drains: [4,5,6].trackItems)
        XCTAssertEqual(tracker.balance(for: secondDate), secondBalance)

        // Test balance containing only source items
        let thirdBalance = DefaultBalance(sources: [7,8,9].trackItems, drains: [].trackItems)
        XCTAssertEqual(tracker.balance(for: thirdDate), thirdBalance)

        // Test balance for non existing group
        let invalidDateBalance = DefaultBalance(sources: [].trackItems, drains: [].trackItems)
        XCTAssertEqual(tracker.balance(for: Date()), invalidDateBalance)
    }

    func test_dateGroup_balanceValueIsCorrectForGroup() {
        let (firstDate, secondDate, thirdDate, tracker) = setupGroupBalanceTracker()

        // Test balance value containing only drain items
        let firstBalance = DefaultBalance(sources: [].trackItems, drains: [1,2,3].trackItems)
        XCTAssertEqual(tracker.balanceValue(for: firstDate), firstBalance.difference)

        // Test balance value containing both source & drain items
        let secondBalance = DefaultBalance(sources: [4,5,6].trackItems, drains: [4,5,6].trackItems)
        XCTAssertEqual(tracker.balanceValue(for: secondDate), secondBalance.difference)

        // Test balance value containing only source items
        let thirdBalance = DefaultBalance(sources: [7,8,9].trackItems, drains: [].trackItems)
        XCTAssertEqual(tracker.balanceValue(for: thirdDate), thirdBalance.difference)

        // Test balance value for non existing group
        let invalidDateBalance = DefaultBalance(sources: [].trackItems, drains: [].trackItems)
        XCTAssertEqual(tracker.balanceValue(for: Date()), invalidDateBalance.difference)
    }

    func test_dateGroup_balanceIsCorrectForDateInterval() {
        let (firstDate, secondDate, thirdDate, tracker) = setupGroupBalanceTracker()

        // Test balance value containing only drain items
        let firstBalance = DefaultBalance(sources: [].trackItems, drains: [1,2,3].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: firstDate, duration: .hour)), firstBalance)

        // Test balance value containing both source & drain items
        let secondBalance = DefaultBalance(sources: [4,5,6].trackItems, drains: [4,5,6].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: secondDate, duration: .hour)), secondBalance)

        // Test balance value containing only source items
        let thirdBalance = DefaultBalance(sources: [7,8,9].trackItems, drains: [].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: thirdDate, duration: .hour)), thirdBalance)

        // Test balance value for all existing group
        let allBalance = DefaultBalance(sources: [4,5,6,7,8,9].trackItems, drains: [1,2,3,4,5,6].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: firstDate, end: thirdDate)), allBalance)

        // Test balance value for invalid interval
        let invalidDateBalance = DefaultBalance(sources: [].trackItems, drains: [].trackItems)
        let invalidInterval = DateInterval(start: Date(timeInterval: .day, since: thirdDate), duration: .hour)
        XCTAssertEqual(tracker.balance(in: invalidInterval), invalidDateBalance)
    }

    func test_dateGroup_balanceValueIsCorrectForDateInterval() {
        let (firstDate, secondDate, thirdDate, tracker) = setupGroupBalanceTracker()

        // Test balance value containing only drain items
        let firstBalanceValue = DefaultBalance(sources: [].trackItems, drains: [1,2,3].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: firstDate, duration: .hour)), firstBalanceValue)

        // Test balance value containing both source & drain items
        let secondBalanceValue = DefaultBalance(sources: [4,5,6].trackItems, drains: [4,5,6].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: secondDate, duration: .hour)), secondBalanceValue)

        // Test balance value containing only source items
        let thirdBalanceValue = DefaultBalance(sources: [7,8,9].trackItems, drains: [].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: thirdDate, duration: .hour)), thirdBalanceValue)

        // Test balance value for all existing group
        let allBalanceValue = DefaultBalance(sources: [4,5,6,7,8,9].trackItems, drains: [1,2,3,4,5,6].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: firstDate, end: thirdDate)), allBalanceValue)

        // Test balance value for invalid interval
        let invalidDateBalanceValue = DefaultBalance(sources: [].trackItems, drains: [].trackItems).difference
        let invalidInterval = DateInterval(start: Date(timeInterval: .day, since: thirdDate), duration: .hour)
        XCTAssertEqual(tracker.balanceValue(in: invalidInterval), invalidDateBalanceValue)
    }

    func test_dateIntervalGroup_noSourcesAreReturnedForOutOfRangeDateIntervals() {
        let (firstInterval, _, thirdInterval, tracker) = setupIntervalGroupBalanceTracker()

        let earlierInterval = DateInterval(start: Date(timeInterval: -.day, since: firstInterval.start), duration: .hour)
        XCTAssertEqual(tracker.sources(in: earlierInterval).count, 0)

        let laterInterval = DateInterval(start: Date(timeInterval: .day, since: thirdInterval.end), duration: .hour)
        XCTAssertEqual(tracker.sources(in: laterInterval).count, 0)
    }

    func test_dateIntervalGroup_correctSourcesAreReturnedForDateIntervals() {
        let (firstInterval, secondInterval, thirdInterval, tracker) = setupIntervalGroupBalanceTracker()

        let firstAndSecondInterval = DateInterval(start: firstInterval.start, end: secondInterval.end)
        XCTAssertEqual(tracker.sources(in: firstAndSecondInterval).count, 3)

        let secondAndThirdInterval = DateInterval(start: secondInterval.start, end: thirdInterval.end)
        XCTAssertEqual(tracker.sources(in: secondAndThirdInterval).count, 6)

        let allInterval = DateInterval(start: firstInterval.start, end: thirdInterval.end)
        XCTAssertEqual(tracker.sources(in: allInterval).count, 6)
    }

    func test_dateIntervalGroup_correctBalanceIsReturnedForDateIntervals() {
        let (firstInterval, secondInterval, thirdInterval, tracker) = setupIntervalGroupBalanceTracker()

        // Test balance containing only drain items
        let firstBalance = DefaultBalance(sources: [].trackItems, drains: [1,2,3].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: firstInterval.start, duration: .day)), firstBalance)

        // Test balance containing both source & drain items
        let secondBalance = DefaultBalance(sources: [4,5,6].trackItems, drains: [4,5,6].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: secondInterval.start, duration: .day)), secondBalance)

        // Test balance containing only source items
        let thirdBalance = DefaultBalance(sources: [7,8,9].trackItems, drains: [].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: thirdInterval.start, duration: .day)), thirdBalance)

        // Test balance for all existing group
        let allBalance = DefaultBalance(sources: [4,5,6,7,8,9].trackItems, drains: [1,2,3,4,5,6].trackItems)
        XCTAssertEqual(tracker.balance(in: DateInterval(start: firstInterval.start, end: thirdInterval.end)), allBalance)

        // Test balance for invalid interval
        let invalidDateBalance = DefaultBalance(sources: [].trackItems, drains: [].trackItems)
        let invalidInterval = DateInterval(start: Date(timeInterval: -.day, since: firstInterval.start), duration: .hour)
        XCTAssertEqual(tracker.balance(in: invalidInterval), invalidDateBalance)
    }

    func test_dateIntervalGroup_correctBalanceValueIsReturnedForDateIntervals() {
        let (firstInterval, secondInterval, thirdInterval, tracker) = setupIntervalGroupBalanceTracker()

        // Test balance value containing only drain items
        let firstBalanceValue = DefaultBalance(sources: [].trackItems, drains: [1,2,3].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: firstInterval.start, duration: .day)), firstBalanceValue)

        // Test balance value containing both source & drain items
        let secondBalanceValue = DefaultBalance(sources: [4,5,6].trackItems, drains: [4,5,6].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: secondInterval.start, duration: .day)), secondBalanceValue)

        // Test balance value containing only source items
        let thirdBalanceValue = DefaultBalance(sources: [7,8,9].trackItems, drains: [].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: thirdInterval.start, duration: .day)), thirdBalanceValue)

        // Test balance value for all existing group
        let allBalanceValue = DefaultBalance(sources: [4,5,6,7,8,9].trackItems, drains: [1,2,3,4,5,6].trackItems).difference
        XCTAssertEqual(tracker.balanceValue(in: DateInterval(start: firstInterval.start, end: thirdInterval.end)), allBalanceValue)

        // Test balance value for invalid interval
        let invalidDateBalanceValue = DefaultBalance(sources: [].trackItems, drains: [].trackItems).difference
        let invalidInterval = DateInterval(start: Date(timeInterval: -.day, since: firstInterval.start), duration: .hour)
        XCTAssertEqual(tracker.balanceValue(in: invalidInterval), invalidDateBalanceValue)
    }

    // MARK: Helpers

    private func setupGroupBalanceTracker() -> (Date, Date, Date, MockDateGroupBalanceTracker) {
        let firstDate = Date()
        let secondDate = Date(timeInterval: .day, since: firstDate)
        let thirdDate = Date(timeInterval: .day, since: secondDate)
        let items: [Date: [MockTrackItem]] = [
            firstDate :  [1,2,3].trackItems,
            secondDate :  [4,5,6].trackItems
        ]
        let sources: [Date: [MockTrackItem]] = [
            secondDate :  [4,5,6].trackItems,
            thirdDate :  [7,8,9].trackItems
        ]
        return (firstDate, secondDate, thirdDate, MockDateGroupBalanceTracker(items: items, sources: sources))
    }

    private func setupIntervalGroupBalanceTracker() -> (DateInterval, DateInterval, DateInterval, MockDateIntervalGroupBalanceTracker) {
        let firstInterval = DateInterval(start: Date(), duration: .day)
        let secondInterval = DateInterval(start: firstInterval.end, duration: .day)
        let thirdInterval = DateInterval(start: secondInterval.end, duration: .day)

        let items: [DateInterval: [MockTrackItem]] = [
            firstInterval :  [1,2,3].trackItems,
            secondInterval :  [4,5,6].trackItems
        ]
        let sources: [DateInterval: [MockTrackItem]] = [
            secondInterval :  [4,5,6].trackItems,
            thirdInterval :  [7,8,9].trackItems
        ]
        return (firstInterval, secondInterval, thirdInterval, MockDateIntervalGroupBalanceTracker(items: items, sources: sources))
    }
}

// MARK: - Mocks

private struct MockDateGroupBalanceTracker: GroupBalanceTracker {
    var items: [Date: [MockTrackItem]]
    var sources: [Date: [MockTrackItem]]
}

private struct MockDateIntervalGroupBalanceTracker: GroupBalanceTracker {
    var items: [DateInterval: [MockTrackItem]]
    var sources: [DateInterval: [MockTrackItem]]
}
