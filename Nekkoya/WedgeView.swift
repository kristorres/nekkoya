import SwiftUI

/// A view that renders a wedge on a roulette-style wheel.
struct WedgeView: View {
    
    /// The label that is displayed on the wedge.
    let label: String
    
    /// The central angle of the wedge.
    let angle: Angle
    
    var body: some View {
        GeometryReader { geometry in
            CircularSector(angle: angle)
                .fill(Color.blue)
                .overlay(
                    Text(label)
                        .offset(x: geometry.size.width / 4)
                        .rotationEffect(angle / 2)
                )
        }
    }
}

#if DEBUG
struct WedgeView_Previews: PreviewProvider {
    static var previews: some View {
        WedgeView(label: "Kris Torres", angle: .degrees(90))
            .rotationEffect(.degrees(10))
            .frame(width: 400, height: 400)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
