import Foundation

extension Measurement: Arithmetical where UnitType : Dimension {

    public static var zero: Measurement<UnitType> {
        return Measurement<UnitType>(value: 0, unit: .baseUnit())
    }
    
}
