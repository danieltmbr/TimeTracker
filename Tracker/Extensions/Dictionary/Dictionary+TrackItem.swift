//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation

extension Dictionary where Key == Date, Value: Collection, Value.Element: TrackItem {

    public func min(in dateInterval: DateInterval) -> Value.Element? {
        return flatValues(in: dateInterval).min()
    }

    public func max(in dateInterval: DateInterval) -> Value.Element? {
        return flatValues(in: dateInterval).max()
    }

    public func sum(in dateInterval: DateInterval) -> Value.Element.Magnitude {
        return flatValues(in: dateInterval).sum()
    }

    public func mean(in dateInterval: DateInterval) -> Value.Element.Magnitude {
        return flatValues(in: dateInterval).mean()
    }

    public func median(in dateInterval: DateInterval) -> Value.Element.Magnitude? {
        return flatValues(in: dateInterval).median()
    }

    public func range(in dateInterval: DateInterval) -> Value.Element.Magnitude? {
        return flatValues(in: dateInterval).range()
    }
}

extension Dictionary where Key == Date, Value: Collection, Value.Element: TrackItem, Value.Element.Magnitude: Hashable {
    /**
     Mode is the value that is repeated more often than any other.
     If list is empty it returns `nil`.
     */
    public func mode(in dateInterval: DateInterval) -> Value.Element.Magnitude? {
        return flatValues(in: dateInterval).mode()
    }
}

extension Dictionary where Key == DateInterval, Value: Collection, Value.Element: TrackItem {

    public func min(in dateInterval: DateInterval) -> Value.Element? {
        return flatValues(in: dateInterval).min()
    }

    public func max(in dateInterval: DateInterval) -> Value.Element? {
        return flatValues(in: dateInterval).max()
    }

    public func sum(in dateInterval: DateInterval) -> Value.Element.Magnitude {
        return flatValues(in: dateInterval).sum()
    }

    public func mean(in dateInterval: DateInterval) -> Value.Element.Magnitude {
        return flatValues(in: dateInterval).mean()
    }

    public func median(in dateInterval: DateInterval) -> Value.Element.Magnitude? {
        return flatValues(in: dateInterval).median()
    }

    public func range(in dateInterval: DateInterval) -> Value.Element.Magnitude? {
        return flatValues(in: dateInterval).range()
    }
}

extension Dictionary where Key == DateInterval, Value: Collection, Value.Element: TrackItem, Value.Element.Magnitude: Hashable {
    /**
     Mode is the value that is repeated more often than any other.
     If list is empty it returns `nil`.
     */
    public func mode(in dateInterval: DateInterval) -> Value.Element.Magnitude? {
        return flatValues(in: dateInterval).mode()
    }
}
