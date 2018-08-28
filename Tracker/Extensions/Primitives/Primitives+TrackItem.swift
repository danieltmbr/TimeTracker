import Foundation

extension Double: TrackItem {
    public var magnitude: Double { return self }
}

extension Float: TrackItem {
    public var magnitude: Float { return self }
}

extension CGFloat: TrackItem {
    public var magnitude: CGFloat { return self }
}
