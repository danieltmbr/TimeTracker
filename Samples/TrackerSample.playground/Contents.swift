import Tracker

/**
 # Examples of using Tracker protocol
 */

struct TimeItem: TrackItem {

    let magnitude: Measurement<UnitDuration>

    let date = Date()

    static func make(_ magnitude: Double, _ unit: UnitDuration = .hours) -> TimeItem {
        return TimeItem(magnitude: Measurement<UnitDuration>(value: magnitude, unit: unit))
    }
}

struct Trck: GroupBalanceTracker {

    typealias Group = DateInterval
    typealias Item = TimeItem
    typealias Source = TimeItem

    private(set) var items: [DateInterval : [TimeItem]] = [:]
    private(set) var sources: [DateInterval : [TimeItem]] = [:]
}

// ---------------------------------

let hour: DateInterval = DateInterval(start: Date(), duration: 60*60)
let nextHour: DateInterval = DateInterval(start: hour.end, duration: 60*60)

let drains: [DateInterval: [TimeItem]] = [
    hour : [.make(1), .make(1)],
    nextHour: [.make(30, .minutes)]
]
let sources: [DateInterval: [TimeItem]] = [
    hour: [.make(1), .make(2)],
    nextHour: [.make(3)]
]

let trck = Trck(items: drains, sources: sources)

// ---------------------------------

trck.balanceValue(in: hour)
trck.items(in: nextHour).sum()
trck.sources(in: hour).mean()
trck.sources(in: hour).range()
