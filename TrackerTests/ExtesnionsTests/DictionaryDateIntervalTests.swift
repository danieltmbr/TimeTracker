//  Copyright © 2018. danieltmbr. All rights reserved.
//

import XCTest

class DictionaryDateIntervalTests: XCTestCase {

    private let firstDate: Date = Date()
    private var secondDate: Date {
        return Date(timeInterval: .day, since: firstDate)
    }

    private let firstInterval = DateInterval(start: Date(), duration: .day)
    private var secondInterval: DateInterval {
        return DateInterval(start: firstInterval.end, duration: .day)
    }

    // MARK: - Date keys

    func test_dictionaryWithDateKeys_getValuesInDateInterval() {
        let dict = [firstDate: 1, secondDate: 2]

        XCTAssertEqual(dict.values(in: DateInterval(start: firstDate, duration: .hour)), [1])
        XCTAssertEqual(dict.values(in: DateInterval(start: secondDate, duration: .hour)), [2])
        XCTAssertEqual(dict.values(in: DateInterval(start: firstDate, end: secondDate)).sorted(), [1, 2])

        let laterDate = Date(timeInterval: .day, since: secondDate)
        XCTAssertEqual(dict.values(in: DateInterval(start: laterDate, duration: .day)), [])
    }

    func test_dictionaryWithDateKeys_getValuesByDateIntervalSubscript() {
        let dict = [firstDate: 1, secondDate: 2]

        XCTAssertEqual(dict[DateInterval(start: firstDate, duration: .hour)], [1])
        XCTAssertEqual(dict[DateInterval(start: secondDate, duration: .hour)], [2])
        XCTAssertEqual(dict[DateInterval(start: firstDate, end: secondDate)].sorted(), [1, 2])

        let laterDate = Date(timeInterval: .day, since: secondDate)
        XCTAssertEqual(dict[DateInterval(start: laterDate, duration: .day)], [])
    }

    func test_dictionaryWithDateKeys_getFlatValuesInDateInterval() {
        let dict = [firstDate: [1], secondDate: [2]]

        XCTAssertEqual(dict.flatValues(in: DateInterval(start: firstDate, duration: .hour)), [1])
        XCTAssertEqual(dict.flatValues(in: DateInterval(start: secondDate, duration: .hour)), [2])
        XCTAssertEqual(dict.flatValues(in: DateInterval(start: firstDate, end: secondDate)).sorted(), [1, 2])

        let laterDate = Date(timeInterval: .day, since: secondDate)
        XCTAssertEqual(dict.flatValues(in: DateInterval(start: laterDate, duration: .day)), [])
    }

    func test_dictionaryWithDateKeys_getFlatValuesByDateIntervalSubscript() {
        let dict = [firstDate: [1], secondDate: [2]]

        XCTAssertEqual(dict[DateInterval(start: firstDate, duration: .hour)], [1])
        XCTAssertEqual(dict[DateInterval(start: secondDate, duration: .hour)], [2])
        XCTAssertEqual(dict[DateInterval(start: firstDate, end: secondDate)].sorted(), [1, 2])

        let laterDate = Date(timeInterval: .day, since: secondDate)
        XCTAssertEqual(dict[DateInterval(start: laterDate, duration: .day)], [])
    }

    // MARK: - DateInterval keys

    func test_dictionaryWithDateIntervalKeys_getValuesInDateInterval() {
        let dict = [firstInterval: 1, secondInterval: 2]

        XCTAssertEqual(dict.values(in: DateInterval(start: firstInterval.start, end: secondInterval.end)).sorted(), [1, 2])

        let laterInterval = DateInterval(start: secondInterval.end, duration: .day)
        XCTAssertEqual(dict.values(in: laterInterval), [])
    }

    func test_dictionaryWithDateIntervalKeys_getFlatValuesInDateInterval() {
        let dict = [firstInterval: [1], secondInterval: [2]]

        XCTAssertEqual(dict.flatValues(in: DateInterval(start: firstInterval.start, end: secondInterval.end)).sorted(), [1, 2])

        let laterInterval = DateInterval(start: secondInterval.end, duration: .day)
        XCTAssertEqual(dict.values(in: laterInterval), [])
    }

    // MARK: - DateIntervals

    func test_dateIntervalContains_inBounds() {
        /**
         |----- interval1 -----|
           |--- interval2 ---|
         */

        let start1 = Date()
        let end1 = Date(timeInterval: .day, since: start1)

        let start2 = Date(timeInterval: .hour, since: start1)
        let end2 = Date(timeInterval: .hour, since: start2)

        let interval1 = DateInterval(start: start1, end: end1)
        let interval2 = DateInterval(start: start2, end: end2)

        XCTAssertTrue(interval1.contains(interval: interval2))
        XCTAssertFalse(interval2.contains(interval: interval1))
    }

    func test_dateIntervalContains_outOfBounds() {
        /**
                           |-- interval1 --|
                                             |-- interval2 --|
         |-- interval3 --|
         */

        let start1 = Date()
        let end1 = Date(timeInterval: .hour, since: start1)

        let start2 = Date(timeInterval: .hour, since: end1)
        let end2 = Date(timeInterval: .hour, since: start2)

        let start3 = Date(timeInterval: -.day, since: start1)
        let end3 = Date(timeInterval: .hour, since: start3)

        let interval1 = DateInterval(start: start1, end: end1)
        let interval2 = DateInterval(start: start2, end: end2)
        let interval3 = DateInterval(start: start3, end: end3)

        XCTAssertFalse(interval1.contains(interval: interval2))
        XCTAssertFalse(interval2.contains(interval: interval1))
        XCTAssertFalse(interval1.contains(interval: interval3))
        XCTAssertFalse(interval3.contains(interval: interval1))
    }

    func test_dateIntervalContains_equalBounds() {
        /**
         |----- interval1 -----|
         |----- interval2 -----|
         */

        let start = Date()
        let end = Date(timeInterval: .day, since: start)

        let interval1 = DateInterval(start: start, end: end)
        let interval2 = DateInterval(start: start, end: end)

        XCTAssertTrue(interval1.contains(interval: interval2))
        XCTAssertTrue(interval2.contains(interval: interval1))
    }

    func test_dateIntervalContains_intersecting() {
        /**
                               |----- interval1 -----|
         |----- interval2 -----|
                    |----- interval3 -----|
                                          |----- interval4 -----|
                                                     |----- interval5 -----|
         */

        let start1 = Date()
        let end1 = Date(timeInterval: .day, since: start1)

        let start2 = Date(timeInterval: -.day, since: start1)
        let end2 = start1

        let start3 = Date(timeInterval: -.day/2, since: start1)
        let end3 = Date(timeInterval: .day, since: start3)

        let start4 = Date(timeInterval: .day/2, since: start1)
        let end4 = Date(timeInterval: .day, since: start4)

        let start5 = end1
        let end5 = Date(timeInterval: .day, since: start5)

        let interval1 = DateInterval(start: start1, end: end1)
        let interval2 = DateInterval(start: start2, end: end2)
        let interval3 = DateInterval(start: start3, end: end3)
        let interval4 = DateInterval(start: start4, end: end4)
        let interval5 = DateInterval(start: start5, end: end5)

        XCTAssertFalse(interval1.contains(interval: interval2))
        XCTAssertFalse(interval1.contains(interval: interval3))
        XCTAssertFalse(interval1.contains(interval: interval4))
        XCTAssertFalse(interval1.contains(interval: interval5))
    }
}
