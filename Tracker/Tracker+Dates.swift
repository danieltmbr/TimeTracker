import Foundation

public extension Tracker where Item: DatedTrackItem {

    public func items(in dateInterval: DateInterval) -> [Item] {
        return items.filter { dateInterval.contains($0.date) }
    }

    public func itemValues(in dateInterval: DateInterval) -> [Item.Magnitude] {
        return items.compactMap { dateInterval.contains($0.date) ? $0.value : nil }
    }

    public func avgItemValue(in dateInterval: DateInterval) -> Item.Magnitude {
        return itemValues(in: dateInterval).avarage()
    }

    public func sumItemValue(in dateInterval: DateInterval) -> Item.Magnitude {
        return itemValues(in: dateInterval).sum()
    }

    public func maxItemValue(in dateInterval: DateInterval) -> Item.Magnitude? {
        return itemValues(in: dateInterval).max()
    }

    public func minItemValue(in dateInterval: DateInterval) -> Item.Magnitude? {
        return itemValues(in: dateInterval).min()
    }

    public func maxItem(in dateInterval: DateInterval) -> Item? {
        return items(in: dateInterval).max { $0.value > $1.value }
    }

    public func minItem(in dateInterval: DateInterval) -> Item? {
        return items(in: dateInterval).min { $0.value < $1.value }
    }
}

// MARK: DateRange Helpers

public extension Tracker where Item: DatedTrackItem {

    /**
     Used for Item date comparisons.

     `Calendar.autoupdatingCurrent` by defult.
     To use another calendar, just simply override this
     `calendar` property by another of your choice.
     */
    public var calendar: Calendar {
        return Calendar.autoupdatingCurrent
    }

    public func items(in range: DateRange) -> [Item] {
        guard let dateInterval = calendar.dateInterval(for: range) else {
            assertionFailure("DateInterval convert failed. Check if your date and components are valid.")
            return []
        }
        return items(in: dateInterval)
    }

    public func itemValues(in range: DateRange) -> [Item.Magnitude] {
        guard let dateInterval = calendar.dateInterval(for: range) else {
            assertionFailure("DateInterval convert failed. Check if your date and components are valid.")
            return []
        }
        return itemValues(in: dateInterval)
    }

    public func avgItemValue(in range: DateRange) -> Item.Magnitude {
        return itemValues(in: range).avarage()
    }

    public func sumItemValue(in range: DateRange) -> Item.Magnitude {
        return itemValues(in: range).sum()
    }

    public func maxItemValue(in range: DateRange) -> Item.Magnitude? {
        return itemValues(in: range).max()
    }

    public func minItemValue(in range: DateRange) -> Item.Magnitude? {
        return itemValues(in: range).min()
    }

    public func maxItem(in range: DateRange) -> Item? {
        return items(in: range).max { $0.value > $1.value }
    }

    public func minItem(in range: DateRange) -> Item? {
        return items(in: range).min { $0.value < $1.value }
    }
}
