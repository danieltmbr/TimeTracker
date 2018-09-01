//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation

extension Calendar {

    public func day(for date: Date = Date()) -> DateInterval? {
        return dateInterval(of: .day, for: date)
    }

    public func week(for date: Date = Date()) -> DateInterval? {
        return dateInterval(of: .weekOfYear, for: date)
    }

    public func month(for date: Date = Date()) -> DateInterval? {
        return dateInterval(of: .month, for: date)
    }

    public func year(for date: Date = Date()) -> DateInterval? {
        return dateInterval(of: .year, for: date)
    }
}
