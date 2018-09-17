//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest

class TrackItemDictionaryTests: XCTestCase {

    func test_min_dateKey() {
        let (interval, items) = setupDatesAndItems()
        XCTAssertEqual(items.min(in: interval), .make(1))
    }

    func test_max_dateKey() {
        let (interval, items) = setupDatesAndItems()
        XCTAssertEqual(items.max(in: interval), .make(11))
    }

    func test_sum_dateKey() {
        let (interval, items) = setupDatesAndItems()
        XCTAssertEqual(items.sum(in: interval), 120)
    }

    func test_mean_dateKey() {
        let (interval, items) = setupDatesAndItems()
        XCTAssertEqual(items.mean(in: interval), 5)
    }

    func test_median_dateKey() {
        let (interval, items) = setupDatesAndItems()
        XCTAssertEqual(items.median(in: interval), 4.5)
    }

    func test_range_dateKey() {
        let (interval, items) = setupDatesAndItems()
        XCTAssertEqual(items.range(in: interval), 10)
    }

    func test_mode_dateKey() {
        let (interval, items) = setupDatesAndItems()
        XCTAssertEqual(items.mode(in: interval), 2)
    }

    private func setupDatesAndItems() -> (DateInterval, [Date: [MockTrackItem]]) {
        let date1 = Date()
        let date2 = Date(timeInterval: .hour, since: date1)
        let date3 = Date(timeInterval: .day, since: date2)

        return (
            DateInterval(start: date1, end: date2),
            [
                date1: [1, 3, 5, 7, 9, 2, 4, 6, 8, 2, 11, 2].trackItems,
                date2: [1, 3, 5, 7, 9, 2, 4, 6, 8, 2, 11, 2].trackItems,
                date3: [7, 7, 7, 7, 7, 7, 7, 7, 7, 23, 452].trackItems
            ]
        )
    }

    func test_min_intervalKey() {
        let (interval, items) = setupDateIntervalsAndItems()
        XCTAssertEqual(items.min(in: interval), .make(1))
    }

    func test_max_intervalKey() {
        let (interval, items) = setupDateIntervalsAndItems()
        XCTAssertEqual(items.max(in: interval), .make(11))
    }

    func test_sum_intervalKey() {
        let (interval, items) = setupDateIntervalsAndItems()
        XCTAssertEqual(items.sum(in: interval), 120)
    }

    func test_mean_intervalKey() {
        let (interval, items) = setupDateIntervalsAndItems()
        XCTAssertEqual(items.mean(in: interval), 5)
    }

    func test_median_intervalKey() {
        let (interval, items) = setupDateIntervalsAndItems()
        XCTAssertEqual(items.median(in: interval), 4.5)
    }

    func test_range_intervalKey() {
        let (interval, items) = setupDateIntervalsAndItems()
        XCTAssertEqual(items.range(in: interval), 10)
    }

    func test_mode_intervalKey() {
        let (interval, items) = setupDateIntervalsAndItems()
        XCTAssertEqual(items.mode(in: interval), 2)
    }

    private func setupDateIntervalsAndItems() -> (DateInterval, [DateInterval: [MockTrackItem]]) {
        let interval1 = DateInterval(start: Date(), duration: .hour)
        let interval2 = DateInterval(start: Date(timeInterval: .hour, since: interval1.end), duration: .hour)
        let interval3 = DateInterval(start: Date(timeInterval: .day, since: interval2.end), duration: .hour)

        return (
            DateInterval(start: interval1.start, end: interval2.end),
            [
                interval1: [1, 3, 5, 7, 9, 2, 4, 6, 8, 2, 11, 2].trackItems,
                interval2: [1, 3, 5, 7, 9, 2, 4, 6, 8, 2, 11, 2].trackItems,
                interval3: [7, 7, 7, 7, 7, 7, 7, 7, 7, 23, 452].trackItems
            ]
        )
    }
}
