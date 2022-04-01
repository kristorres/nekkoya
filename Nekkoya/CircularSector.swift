import SwiftUI

/// A sector of a circle that is centered in the view containing it.
struct CircularSector: Shape {
    
    /// The central angle.
    let angle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.move(to: center)
            path.addArc(
                center: center,
                radius: rect.width / 2,
                startAngle: .zero,
                endAngle: angle,
                clockwise: false
            )
        }
    }
}
