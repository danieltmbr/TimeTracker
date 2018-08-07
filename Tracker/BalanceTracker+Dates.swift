import Foundation

public extension BalanceTracker where Source: DatedTrackItem {

    public func sources(in dateInterval: DateInterval) -> [Source] {
        return sources.filter { dateInterval.contains($0.date) }
    }

    public func sourceValues(in dateInterval: DateInterval) -> [Source.Magnitude] {
        return sources.compactMap { dateInterval.contains($0.date) ? $0.value : nil }
    }

    public func avgSourceValue(in dateInterval: DateInterval) -> Source.Magnitude {
        return sourceValues(in: dateInterval).avarage()
    }

    public func sumSourceValue(in dateInterval: DateInterval) -> Source.Magnitude {
        return sourceValues(in: dateInterval).sum()
    }

    public func maxSourceValue(in dateInterval: DateInterval) -> Source.Magnitude? {
        return sourceValues(in: dateInterval).max()
    }

    public func minSourceValue(in dateInterval: DateInterval) -> Source.Magnitude? {
        return sourceValues(in: dateInterval).min()
    }

    public func maxSource(in dateInterval: DateInterval) -> Source? {
        return sources(in: dateInterval).max { $0.value > $1.value }
    }

    public func minSource(in dateInterval: DateInterval) -> Source? {
        return sources(in: dateInterval).min { $0.value < $1.value }
    }
}

// MARK: DateRange Helpers

public extension BalanceTracker where Source: DatedTrackItem {

    /**
     Used for Source date comparisons.

     `Calendar.autoupdatingCurrent` by defult.
     To use another calendar, just simply override this
     `calendar` property by another of your choice.
     */
    public var calendar: Calendar {
        return Calendar.autoupdatingCurrent
    }

    public func sources(in range: DateRange) -> [Source] {
        guard let dateInterval = calendar.dateInterval(for: range) else {
            assertionFailure("DateInterval convert failed. Check if your date and components are valid.")
            return []
        }
        return sources(in: dateInterval)
    }

    public func sourceValues(in range: DateRange) -> [Source.Magnitude] {
        guard let dateInterval = calendar.dateInterval(for: range) else {
            assertionFailure("DateInterval convert failed. Check if your date and components are valid.")
            return []
        }
        return sourceValues(in: dateInterval)
    }

    public func avgSourceValue(in range: DateRange) -> Source.Magnitude {
        return sourceValues(in: range).avarage()
    }

    public func sumSourceValue(in range: DateRange) -> Source.Magnitude {
        return sourceValues(in: range).sum()
    }

    public func maxSourceValue(in range: DateRange) -> Source.Magnitude? {
        return sourceValues(in: range).max()
    }

    public func minSourceValue(in range: DateRange) -> Source.Magnitude? {
        return sourceValues(in: range).min()
    }

    public func maxSource(in range: DateRange) -> Source? {
        return sources(in: range).max { $0.value > $1.value }
    }

    public func minSource(in range: DateRange) -> Source? {
        return sources(in: range).min { $0.value < $1.value }
    }
}

public extension BalanceTracker where Source: DatedTrackItem, Item: DatedTrackItem {

    public func balance(in dateInterval: DateInterval) -> Source.Magnitude {
        return sumSourceValue(in: dateInterval) - sumItemValue(in: dateInterval)
    }

    public func balance(in range: DateRange) -> Source.Magnitude? {
        guard let dateInterval = calendar.dateInterval(for: range) else {
            assertionFailure("DateInterval convert failed. Check if your date and components are valid.")
            return nil
        }
        return balance(in: dateInterval)
    }
}

