//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation

public protocol GroupTracker {
    /// Represents the type of stored objects
    associatedtype Item: TrackItem
    /// Represents a type which the groupping of `items` is based on.
    associatedtype Group: Hashable

    /**
     `Groupped` collection of `Item`s.
     The following operations are available on an `Item` array:

     - `sum()`
     - `mean()`
     - `median()`
     - `mode()` (if `TrackItem` is `Hashable`)
     - `range()`
     - `min()`
     - `max()`

     - SeeAlso: [Array+TrackItem.swift](file:///Extensions/Array/Array+TrackItem.swift)
     */
    var items: [Group: [Item]] { get }
}

extension GroupTracker {
    /// All stored `Item`s without groupping.
    public var allItems: [Item] { return items.flatMap { $0.value } }
}

extension GroupTracker where Group == Date, Item: TrackItem {
    /**
     When `items` are groupped by `Date`, you can select all
     items from multiple groups which are inside of a `DateInterval`.
     - Complexity: O(n)
     - Parameter dateInterval: Date range for which the items will be listed.
     - Returns: Flattaned `Item` list containing all the items
       from groups which are in the range of a `DateInterval`
     */
    public func items(in dateInterval: DateInterval) -> [Item] {
        return items.flatValues(in: dateInterval)
    }
}

extension GroupTracker where Group == DateInterval, Item: TrackItem {
    /**
     When `items` are groupped by `DateInterval`, you can select all
     items from multiple groups which are inside of a `DateInterval`.
     - Complexity: O(n)
     - Parameter dateInterval: Date range for which the items will be listed.
     - Returns: Flattaned `Item` list containing all the items
     from groups which are in the range of a `DateInterval`
     */
    public func items(in dateInterval: DateInterval) -> [Item] {
        return items.flatValues(in: dateInterval)
    }
}
