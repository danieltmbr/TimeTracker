import Foundation

// MARK: -

public protocol TrackItem: Equatable {
    associatedtype Magnitude: Arithmetical

    var value: Magnitude { get }
}

public protocol DatedTrackItem: TrackItem {
    var date: Date { get }
}

// MARK: - Foundation's extension

extension Double: TrackItem {
    public var value: Double { return self }
}

extension Float: TrackItem {
    public var value: Float { return self }
}

extension CGFloat: TrackItem {
    public var value: CGFloat { return self }
}

extension Measurement: TrackItem where UnitType: Dimension {
    public var value: Measurement<UnitType> { return self }
}
