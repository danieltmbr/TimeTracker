import Tracker

/*:
 # Examples of using Tracker protocol

 The purpose of Tracker protocol is to easly 
 */

struct TimeItem: DatedTrackItem {

    let value: Measurement<UnitDuration>

    let date = Date()

    static func make(_ value: Double, _ unit: UnitDuration = .hours) -> TimeItem {
        return TimeItem(value: Measurement<UnitDuration>(value: value, unit: unit))
    }
}

struct Trck: BalanceTracker {
    private(set) var items: [TimeItem] = []
    private(set) var sources: [TimeItem] = []
}

let trck = Trck(
    items: [.make(1), .make(2), .make(30, .minutes)],
    sources: [.make(1), .make(2), .make(30, .minutes)]
)

trck.avgItemValue()
trck.avgSourceValue()

trck.sumItemValue() == trck.sumSourceValue()

trck.avgSourceValue(in: .day())

