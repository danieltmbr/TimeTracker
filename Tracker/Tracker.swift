import Foundation

// MARK: -

public protocol Tracker {
    associatedtype Item: TrackItem

    var items: [Item] { get }
}

// TODO: mean, mode, median, range
public extension Tracker {
    /**
     Accumulated value of `items`.
     If list is empty it returns the `zero` value of `Item.Magnitude`.
     */
    public func sumItemValue() -> Item.Magnitude {
        return items.values.sum()
    }

    /**
     Avarage value of `items`.
     If list is empty it returns the `zero` value of `Item.Magnitude`.
     */
    public func avgItemValue() -> Item.Magnitude {
        return items.values.avarage()
    }

    /**
     Min value of `items`.
     If list is empty it returns `nil`.
     */
    public func minItemValue() -> Item.Magnitude? {
        return items.values.min()
    }

    /**
     Max value of the `items`.
     If list is empty it returns `nil`.
     */
    public func maxItemValue() -> Item.Magnitude? {
        return items.values.max()
    }

    /**
     Item of `items` with the lowest `value`.
     If list is empty it returns `nil`.
     */
    public func minItem() -> Item? {
        return items.min { $0.value < $1.value }
    }

    /**
     Item of `items` with the highest `value`.
     If list is empty it returns `nil`.
     */
    public func maxItem() -> Item? {
        return items.max { $0.value > $1.value }
    }
}

// MARK: - TrackItem List values helper

extension Array where Element: TrackItem {

    var values: [Element.Magnitude] {
        return map { $0.value }
    }
}
