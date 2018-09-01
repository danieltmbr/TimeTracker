//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation

extension Measurement: TrackItem where UnitType: Dimension {
    public typealias Magnitude = Measurement<UnitType>

    public var magnitude: Measurement<UnitType> {
        return Measurement(value: abs(value), unit: unit)
    }
}
