import Foundation

public protocol GrouppedTracker: Tracker {

    associatedtype Group: Hashable

    var itemGroups: [Group: [Item]] { get }
}

extension GrouppedTracker {
    var items: [Item] { return itemGroups.flatMap { $0.value } }
}

public protocol GrouppedBalanceTracker: GrouppedTracker, BalanceTracker {
    var sourceGroups: [Group: [Source]] { get }
}

extension GrouppedBalanceTracker {
    var sources: [Source] { return sourceGroups.flatMap { $0.value } }
}
