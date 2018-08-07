import Foundation

// MARK: -

public protocol Arithmetical: Comparable {

    /// Zero value of Arithmetical
    static var zero: Self { get }

    /// Add two Arithmetical of the same type.
    static func + (lhs: Self, rhs: Self) -> Self

    /// Subtract two Arithmetical of the same type.
    static func - (lhs: Self, rhs: Self) -> Self

    /// Multiply a Arithmetical by a scalar value.
    static func * (lhs: Self, rhs: Double) -> Self

    /// Multiply a scalar value by a Arithmetical.
    static func * (lhs: Double, rhs: Self) -> Self

    /// Divide a Arithmetical by a scalar value.
    static func / (lhs: Self, rhs: Double) -> Self

    /// Divide a scalar value by a Arithmetical.
    static func / (lhs: Double, rhs: Self) -> Self
}

// MARK: - Foundation extensions to Arithmetical

extension Double: Arithmetical {
    public static var zero: Double { return 0 }
}

extension Float: Arithmetical {

    public static var zero: Float { return 0 }

    public static func * (lhs: Float, rhs: Double) -> Float {
        return lhs * Float(rhs)
    }

    public static func * (lhs: Double, rhs: Float) -> Float {
        return Float(lhs) * rhs
    }

    public static func / (lhs: Float, rhs: Double) -> Float {
        return lhs / Float(rhs)
    }

    public static func / (lhs: Double, rhs: Float) -> Float {
        return Float(lhs) / rhs
    }
}

extension CGFloat: Arithmetical {

    public static var zero: CGFloat { return 0 }

    public static func * (lhs: CGFloat, rhs: Double) -> CGFloat {
        return lhs * CGFloat(rhs)
    }

    public static func * (lhs: Double, rhs: CGFloat) -> CGFloat {
        return CGFloat(lhs) * rhs
    }

    public static func / (lhs: CGFloat, rhs: Double) -> CGFloat {
        return lhs / CGFloat(rhs)
    }

    public static func / (lhs: Double, rhs: CGFloat) -> CGFloat {
        return CGFloat(lhs) / rhs
    }
}

extension Measurement: Arithmetical where UnitType : Dimension {
    public static var zero: Measurement<UnitType> {
        return Measurement<UnitType>(value: 0, unit: .baseUnit())
    }
}

// MARK: - Internal Helper methods for Arithemetical lists

extension Array where Element: Arithmetical {

    /**
     Accumulated value of Arithmetical elements.
     If list is empty it returns the `zero` value of TrackUnit.
     */
    func sum() -> Element {
        return reduce(Element.zero, +)
    }

    /**
     Avarage value of Arithmetical elements.
     If list is empty it returns the `zero` value of TrackUnit.
     */
    func avarage() -> Element {
        return isEmpty ? .zero : sum() / Double(count)
    }
}
