import SwiftUI

extension Angle {
    
    /// Normalizes the angle in the interval [0, 2π).
    mutating func normalize() {
        self = .radians(radians.truncatingRemainder(dividingBy: .pi * 2))
    }
}
