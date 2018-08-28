import Foundation

public protocol Balance {
    /// Type that represents the volume of balance
    associatedtype Magnitude: Arithmetical

    var source: Magnitude { get }
    var drain: Magnitude { get }
    /// Difference of source and drain
    var difference: Magnitude { get }
}

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

// MARK: - Balance

public extension BalanceTracker {

    /**
     Difference between `sum()` of `sources` and `sum()` of `items`.
     - Complexity: O(n)
     - Returns: Magnitude of the difference, sum of `sources`, sum of `items`.
     */
    public func balance() -> DefaultBalance<Source.Magnitude> {
        return DefaultBalance(source: sources.sum(), drain: items.sum())
    }

    public func balanceValue() -> Source.Magnitude {
        return balance().difference
    }
}

// MARK: - Default Balance implementation

public struct DefaultBalance<BalanceType>: Balance where BalanceType: Arithmetical {
    public let source: BalanceType
    public let drain: BalanceType

    public init(source: BalanceType, drain: BalanceType) {
        self.source = source
        self.drain = drain
    }
}

extension Balance {
    public var difference: Magnitude {
        return source - drain
    }
}

