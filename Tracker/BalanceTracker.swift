import Foundation

public protocol BalanceTracker: Tracker {
    associatedtype Source: TrackItem where Source.Magnitude == Item.Magnitude

    var sources: [Source] { get }
}

public extension BalanceTracker {
    /**
     Accumulated value of `sources`.
     If list is empty it returns the `zero` value of `Source.Magnitude`.
     */
    public func sumSourceValue() -> Source.Magnitude {
        return sources.values.sum()
    }

    /**
     Avarage value of the `sources`.
     If list is empty it returns the `zero` value of `Source.Magnitude`.
     */
    public func avgSourceValue() -> Source.Magnitude {
        return sources.values.avarage()
    }

    /**
     Min value of `sources`.
     If list is empty it returns `nil`.
     */
    public func minSourceValue() -> Source.Magnitude? {
        return sources.values.min()
    }

    /**
     Max value of `sources`.
     If list is empty it returns `nil`.
     */
    public func maxSourceValue() -> Source.Magnitude? {
        return sources.values.max()
    }

    /**
     Item of `sources` with the lowest `value`.
     If list is empty it returns `nil`.
     */
    public func minSource() -> Source? {
        return sources.min { $0.value < $1.value }
    }

    /**
     Item of `sources` with the highest `value`.
     If list is empty it returns `nil`.
     */
    public func maxSource() -> Source? {
        return sources.max { $0.value > $1.value }
    }

    /**
     Magnitude of all source value extracted the item  values.
     */
    public func balance() -> Source.Magnitude {
        return sumSourceValue() - sumItemValue()
    }
}
