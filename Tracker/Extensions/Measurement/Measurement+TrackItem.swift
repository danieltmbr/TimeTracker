import Foundation

extension Measurement: TrackItem where UnitType: Dimension {
    public typealias Magnitude = Measurement<UnitType>

    public var magnitude: Measurement<UnitType> { return self }
}
