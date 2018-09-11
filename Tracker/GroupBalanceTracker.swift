//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

public protocol GroupBalanceTracker: GroupTracker {
    /// Represents the type of objects that are stored as "sources"
    associatedtype Source: TrackItem where Source.Magnitude == Item.Magnitude
    associatedtype BalanceType: Balance where BalanceType.Magnitude == Item.Magnitude

    /**
     `Groupped` collection of `Source`s.
     `Source` elements `magnitude`'s are calculated in opposed to `items` when calculating `balance()`.

     The following operations are available on `TrackItem` arrays:
     - `sum()`
     - `mean()`
     - `median()`
     - `mode()` (if `Item` is `Hashable`)
     - `range()`
     - `min()`
     - `max()`

     - SeeAlso: [Array+TrackItem.swift](file:///Extensions/Array/Array+TrackItem.swift)
     */
    var sources: [Group: [Source]] { get }

    /**
     Difference between sum of `sources` and sum of `items`
     in a group if exists.
     */
    func balance(for group: Group) -> BalanceType
}

extension GroupBalanceTracker {
    /// All stored `Source`s without groupping.
    public var allSources: [Source] { return sources.flatMap { $0.value } }

    /**
     Difference between `sum()` of `sources` and `sum()` of `items`.
     - Complexity: O(n)
     - Returns: Magnitude of the difference, sum of `sources`, sum of `items`.
     */
    public func balance(for group: Group) -> DefaultBalance<Source.Magnitude> {
        return DefaultBalance(
            sources: sources[group] ?? [],
            drains: items[group] ?? []
        )
    }

    public func balanceValue(for group: Group) -> Source.Magnitude {
        return balance(for: group).difference
    }
}

extension GroupBalanceTracker where Group == Date, Source: TrackItem {
    /**
     When `sources` are groupped by `Date`, you can select all
     sources from multiple groups which are inside of a `DateInterval`.
     - Complexity: O(n)
     - Parameter dateInterval: Date range for which the sources will be listed.
     - Returns: Flattaned `Source` list containing all the sources
     from groups which in the range of a `DateInterval`
     */
    public func sources(in dateInterval: DateInterval) -> [Source] {
        return sources.flatValues(in: dateInterval)
    }

    public func balance(in dateInterval: DateInterval) -> DefaultBalance<Source.Magnitude> {
        return DefaultBalance(
            source: sources.sum(in: dateInterval),
            drain: items.sum(in: dateInterval)
        )
    }

    public func balanceValue(in dateInterval: DateInterval) -> Source.Magnitude {
        return balance(in: dateInterval).difference
    }
}

extension GroupBalanceTracker where Group == DateInterval, Source: TrackItem {
    /**
     When `sources` are groupped by `DateInterval`, you can select all
     sources from multiple groups which are inside of a `DateInterval`.
     - Complexity: O(n)
     - Parameter dateInterval: Date range for which the sources will be listed.
     - Returns: Flattaned `Source` list containing all the sources
     from groups which in the range of a `DateInterval`
     */
    public func sources(in dateInterval: DateInterval) -> [Source] {
        return sources.flatValues(in: dateInterval)
    }

    public func balance(in dateInterval: DateInterval) -> DefaultBalance<Source.Magnitude> {
        return DefaultBalance(
            source: sources.sum(in: dateInterval),
            drain: items.sum(in: dateInterval)
        )
    }

    public func balanceValue(in dateInterval: DateInterval) -> Source.Magnitude {
        return balance(in: dateInterval).difference
    }
}
