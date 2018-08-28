import Tracker

/*:
 # Examples of using Tracker protocol

 The purpose of Tracker protocol is to easly 
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

let trck = Trck(items: [:], sources: [:])
//    items: [.make(1), .make(2), .make(30, .minutes)],
//    sources: [.make(1), .make(2), .make(30, .minutes)]
//)

let items = trck.items.values(in: DateInterval(start: Date(), duration: 60*60*24)).flatMap { $0 }

//
//trck.meanItemValue()
//trck.meanSourceValue()
//
//trck.sumItemValue() == trck.sumSourceValue()
//
//trck.meanSourceValue(in: .day())

