import Foundation

public protocol Arithmetical: Comparable {

    /// Zero value of `Arithmetical`
    static var zero: Self { get }

    /// Add two `Arithmetical` of the same type.
    static func + (lhs: Self, rhs: Self) -> Self

    /// Subtract two `Arithmetical` of the same type.
    static func - (lhs: Self, rhs: Self) -> Self

    /// Multiply a `Arithmetical` by a scalar value.
    static func * (lhs: Self, rhs: Double) -> Self

    /// Multiply a scalar value by a `Arithmetical`.
    static func * (lhs: Double, rhs: Self) -> Self

    /// Divide a `Arithmetical` by a scalar value.
    static func / (lhs: Self, rhs: Double) -> Self

    /// Divide a scalar value by a `Arithmetical`.
    static func / (lhs: Double, rhs: Self) -> Self
}
