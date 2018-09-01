//  Copyright © 2018. danieltmbr. All rights reserved.

import XCTest
@testable import Tracker

class GroupTrackerTests: XCTestCase {

    func test_allItemsAreCorrect() {
        let date1 = Date()
        let date2 = Date(timeInterval: .day, since: date1)
        let items: [Date: [MockTrackItem]] = [
            date1 :  [1,2,3].trackItems,
            date2 :  [4,5,6].trackItems
        ]
        let tracker = MockDateGroupTracker(items: items)

        let allItems = tracker.allItems.sorted()
        XCTAssertEqual(allItems, [1,2,3,4,5,6].trackItems)
    }

    func test_dateGroup_noItemsAreReturnedForOutOfRangeDateIntervals() {
        let firstDate = Date()
        let secondDate = Date(timeInterval: .day, since: firstDate)
        let items: [Date: [MockTrackItem]] = [
            firstDate :  [1,2,3].trackItems,
            secondDate :  [4,5,6].trackItems
        ]
        let tracker = MockDateGroupTracker(items: items)

        let earlierInterval = DateInterval(start: Date(timeInterval: -.day, since: firstDate), duration: .hour)
        XCTAssertEqual(tracker.items(in: earlierInterval).count, 0)

        let laterInterval = DateInterval(start: Date(timeInterval: .day, since: secondDate), duration: .hour)
        XCTAssertEqual(tracker.items(in: laterInterval).count, 0)
    }

    func test_dateGroup_correctItemsAreReturnedForDateIntervals() {
        let firstDate = Date()
        let secondDate = Date(timeInterval: .day, since: firstDate)
        let items: [Date: [MockTrackItem]] = [
            firstDate :  [1,2,3].trackItems,
            secondDate :  [4,5,6].trackItems
        ]
        let tracker = MockDateGroupTracker(items: items)

        let intervalContainingFirstDate = DateInterval(start: Date(timeInterval: 0, since: firstDate), duration: .hour)
        XCTAssertEqual(tracker.items(in: intervalContainingFirstDate), [1,2,3].trackItems)

        let intervalContainingSecondDate = DateInterval(start: Date(timeInterval: 0, since: secondDate), duration: .hour)
        XCTAssertEqual(tracker.items(in: intervalContainingSecondDate), [4,5,6].trackItems)

        let intervalContainingBothDates = DateInterval(start: Date(timeInterval: 0, since: firstDate), duration: .day)
        XCTAssertEqual(tracker.items(in: intervalContainingBothDates).sorted(), [1,2,3,4,5,6].trackItems)
    }

    func test_dateIntervalGroup_noItemsAreReturnedForOutOfRangeDateIntervals() {
        let firstInterval = DateInterval(start: Date(), duration: .day)
        let secondInterval = DateInterval(start: firstInterval.end, duration: .day)
        let items: [DateInterval: [MockTrackItem]] = [
            firstInterval :  [1,2,3].trackItems,
            secondInterval :  [4,5,6].trackItems
        ]
        let tracker = MockDateIntervalGroupTracker(items: items)

        let earlierInterval = DateInterval(start: Date(timeInterval: -.day, since: firstInterval.start), duration: .hour)
        XCTAssertEqual(tracker.items(in: earlierInterval).count, 0)

        let laterInterval = DateInterval(start: Date(timeInterval: .day, since: secondInterval.end), duration: .hour)
        XCTAssertEqual(tracker.items(in: laterInterval).count, 0)
    }

    func test_dateIntervalGroup_correctItemsAreReturnedForDateIntervals() {
        let firstInterval = DateInterval(start: Date(), duration: .day)
        let secondInterval = DateInterval(start: firstInterval.end, duration: .day)
        let items: [DateInterval: [MockTrackItem]] = [
            firstInterval :  [1,2,3].trackItems,
            secondInterval :  [4,5,6].trackItems
        ]
        let tracker = MockDateIntervalGroupTracker(items: items)

        let intervalContainingFirstDateInterval = DateInterval(start: firstInterval.start, duration: .day)
        XCTAssertEqual(tracker.items(in: intervalContainingFirstDateInterval), [1,2,3].trackItems)

        let intervalContainingSecondDateInterval = DateInterval(start: secondInterval.start, duration: .day)
        XCTAssertEqual(tracker.items(in: intervalContainingSecondDateInterval), [4,5,6].trackItems)

        let intervalContainingBothDatesInterval = DateInterval(start: firstInterval.start, end: secondInterval.end)
        XCTAssertEqual(tracker.items(in: intervalContainingBothDatesInterval).sorted(), [1,2,3,4,5,6].trackItems)
    }

}

private struct MockDateGroupTracker: GroupTracker {
    var items: [Date: [MockTrackItem]]
}

private struct MockDateIntervalGroupTracker: GroupTracker {
    var items: [DateInterval: [MockTrackItem]]
}

extension TimeInterval {
    static let hour: TimeInterval = 60 * 60
    static let day: TimeInterval = 24 * 60 * 60
}
