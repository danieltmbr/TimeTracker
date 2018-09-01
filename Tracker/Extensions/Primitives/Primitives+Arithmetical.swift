//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation

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
