//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation

public protocol Tracker {
    /// Represents the type of stored objects
    associatedtype Item: TrackItem

    /**
     `TrackItem` elements on which the following operations are available:

     - `sum()`
     - `mean()`
     - `median()`
     - `mode()` (if `TrackItem` is `Hashable`)
     - `range()`
     - `min()`
     - `max()`

     - SeeAlso: [Array+TrackItem.swift](file:///Extensions/Array/Array+TrackItem.swift)
     */
    var items: [Item] { get }
}
