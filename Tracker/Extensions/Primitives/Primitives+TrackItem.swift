//  Copyright © 2018. danieltmbr. All rights reserved.

import Foundation

extension Double: TrackItem {
    public var magnitude: Double { return abs(self) }
}

extension Float: TrackItem {
    public var magnitude: Float { return abs(self) }
}

extension CGFloat: TrackItem {
    public var magnitude: CGFloat { return abs(self) }
}
