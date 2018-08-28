import Foundation

extension Array where Element: Arithmetical {

    /**
     Accumulated value of Arithmetical elements.
     If list is empty it returns the `zero` value of TrackUnit.
     */
    public func sum() -> Element {
        return reduce(Element.zero, +)
    }

    /**
     Avarage value of Arithmetical elements.
     If list is empty it returns the `zero` value of TrackUnit.
     */
    public func mean() -> Element {
        return isEmpty ? .zero : sum() / Double(count)
    }

    /**
     The median is the "middle" value in the sorted version of the list.
     If there is no "middle" number, because there are an even number of number,
     the median of the list will be the mean of the "middle" two values within the list.
     If list is empty it returns `nil`.
     */
    public func median() -> Element? {
        guard count > 0
            else { return nil }
        let sortedList = sorted()
        let index = count/2
        return count % 2 == 0
            ? (sortedList[index] + sortedList[index+1])/2
            : sortedList[index]
    }

    /**
     Range value of Arithmetical elements (maxValue - minValue).
     If list is empty it returns `nil`.
     */
    public func range() -> Element? {
        guard let max = self.max(), let min = self.min()
            else { return nil }
        return max - min
    }
}

extension Array where Element: Arithmetical, Element: Hashable {
    /**
     Mode is the value that is repeated more often than any other.
     If list is empty it returns `nil`.
     */
    public func mode() -> Element? {
        let counts = Dictionary(map { ($0, 1) }, uniquingKeysWith: +)
        return counts.max { $0.value > $1.value }?.key
    }
}
