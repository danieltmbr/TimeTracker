//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

// MARK: -

public protocol TrackItem: Comparable {
    /// Type of the volume that the TrackItem represents
    associatedtype Magnitude: Arithmetical

    /// The volume of a TrackItem
    var magnitude: Magnitude { get }
}

// MARK: - Comparable implementation

extension TrackItem {

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.magnitude < rhs.magnitude
    }

    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.magnitude <= rhs.magnitude
    }

    public static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.magnitude > rhs.magnitude
    }

    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.magnitude >= rhs.magnitude
    }
}
