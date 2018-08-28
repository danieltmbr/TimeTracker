import Foundation

extension Dictionary where Key == Date {

    public func values(in dateInterval: DateInterval) -> [Value] {
        return compactMap { dateInterval.contains($0.key) ? $0.value : nil }
    }

    subscript(interval: DateInterval) -> [Value] {
        return values(in: interval)
    }
}

extension Dictionary where Key == Date, Value: Collection {

    public func flatValues(in dateInterval: DateInterval) -> [Value.Element] {
        return filter { dateInterval.contains($0.key) }.flatMap { $0.value }
    }

    subscript(interval: DateInterval) -> [Value.Element] {
        return flatValues(in: interval)
    }
}

extension Dictionary where Key == DateInterval {

    public func values(in dateInterval: DateInterval) -> [Value] {
        return compactMap { dateInterval.contains(interval: $0.key) ? $0.value : nil }
    }
}

extension Dictionary where Key == DateInterval, Value: Collection {

    public func flatValues(in dateInterval: DateInterval) -> [Value.Element] {
        return filter { dateInterval.contains(interval: $0.key) }.flatMap { $0.value }
    }
}

extension DateInterval {
    public func contains(interval: DateInterval) -> Bool {
        return start <= interval.start && end >= interval.end
    }
}
