//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

// MARK: -

public protocol Balance {
    /// Type that represents the volume of balance
    associatedtype Magnitude: Arithmetical

    var source: Magnitude { get }
    var drain: Magnitude { get }
    /// Difference of source and drain
    var difference: Magnitude { get }
}

// MARK: Difference default implementation

extension Balance {
    public var difference: Magnitude {
        return source - drain
    }
}

// MARK: -

public struct DefaultBalance<BalanceType>: Balance where BalanceType: Arithmetical {
    public let source: BalanceType
    public let drain: BalanceType

    public init(source: BalanceType, drain: BalanceType) {
        self.source = source
        self.drain = drain
    }

    public init<Source, Drain>(sources: [Source], drains: [Drain])
        where Source: TrackItem, Source.Magnitude == BalanceType, Drain: TrackItem, Drain.Magnitude == BalanceType {
            self.source = sources.sum()
            self.drain = drains.sum()
    }
}

// MARK: Equatable conformance

extension DefaultBalance: Equatable {}

