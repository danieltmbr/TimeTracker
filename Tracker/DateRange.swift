import Foundation

public struct DateRange: Hashable {

    let component: Calendar.Component

    let date: Date

    public init(date: Date, component: Calendar.Component) {
        self.component = component
        self.date = date
    }

    /// Day contains the give Date
    public static func day(of date: Date = Date()) -> DateRange {
        return DateRange(date: date, component: .day)
    }

    /// Week of year contains the give Date
    public static func week(of date: Date = Date()) -> DateRange {
        return DateRange(date: date, component: .weekOfYear)
    }

    /// Month contains the give Date
    public static func month(of date: Date = Date()) -> DateRange {
        return DateRange(date: date, component: .month)
    }

    /// Year contains the give Date
    public static func year(of date: Date = Date()) -> DateRange {
        return DateRange(date: date, component: .year)
    }
}

extension Calendar {
    public func dateInterval(for range: DateRange) -> DateInterval? {
        return dateInterval(of: range.component, for: range.date)
    }
}
