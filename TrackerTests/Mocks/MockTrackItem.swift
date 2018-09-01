//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation
import Tracker

struct MockTrackItem: TrackItem {
    var magnitude: Double
    static func make(_ double: Double) -> MockTrackItem {
        return MockTrackItem(magnitude: double)
    }
}

extension Array where Element == Double {
    var trackItems: [MockTrackItem] { return map { .make($0) } }
}
