//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

// MARK: -

public protocol BalanceTracker: Tracker {
    /// Represents the type of objects that are stored as "sources"
    associatedtype Source: TrackItem where Source.Magnitude == Item.Magnitude
    associatedtype BalanceType: Balance where BalanceType.Magnitude == Item.Magnitude

    /**
     `TrackItem` elements which `magnitude`'s are calculated in opposed to `items` when calculating `balance()`.

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
    var sources: [Source] { get }

    /**
     Difference between sum of `sources` and sum of `items`.
     - Return: Balance of tracked `sources` and `items`
     */
    func balance() -> BalanceType
}

// MARK: - BalanceTracker default implementations

public extension BalanceTracker {

    /**
     Difference between `sum()` of `sources` and `sum()` of `items`.
     - Complexity: O(n)
     - Returns: Magnitude of the difference, sum of `sources`, sum of `items`.
     */
    public func balance() -> DefaultBalance<Source.Magnitude> {
        return DefaultBalance(sources: sources, drains: items)
    }

    /**
     Helper methods which only returns the actual value of the balance.
     If maginute of the sources and drains needed use `balance()`.
     */
    public func balanceValue() -> Source.Magnitude {
        return balance().difference
    }
}
