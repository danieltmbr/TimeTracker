//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

public extension Array where Element: TrackItem {

    public var magnitudes: [Element.Magnitude] {
        return map { $0.magnitude }
    }

    /**
     Accumulated value of TrackItem elements.
     If list is empty it returns the `zero` value of TrackUnit.
     */
    public func sum() -> Element.Magnitude {
        return reduce(Element.Magnitude.zero) { $0 + $1.magnitude }
    }

    /**
     Avarage value of TrackItem elements.
     If list is empty it returns the `zero` value of TrackUnit.
     */
    public func mean() -> Element.Magnitude {
        return isEmpty ? .zero : sum() / Double(count)
    }

    /**
     The median is the "middle" value in the sorted version of the list.
     If there is no "middle" number, because there are an even number of number,
     the median of the list will be the mean of the "middle" two values within the list.
     If list is empty it returns `nil`.
     */
    public func median() -> Element.Magnitude? {
        guard count > 0
            else { return nil }
        let sortedList = sorted()
        let index = count/2
        return count % 2 == 0
            ? (sortedList[index-1].magnitude + sortedList[index].magnitude)/Double(2)
            : sortedList[index].magnitude
    }

    /**
     Range value of TrackItem elements (maxValue - minValue).
     If list is empty it returns `nil`.
     */
    public func range() -> Element.Magnitude? {
        guard let max = self.max(), let min = self.min()
            else { return nil }
        return max.magnitude - min.magnitude
    }
}

extension Array where Element: TrackItem, Element.Magnitude: Hashable {
    /**
     Mode is the value that is repeated more often than any other.
     If list is empty it returns `nil`.
     */
    public func mode() -> Element.Magnitude? {
        let counts = Dictionary(map { ($0.magnitude, 1) }, uniquingKeysWith: +)
        return counts.max { $0.value < $1.value }?.key
    }
}

