import SwiftUI

/// A view that renders a wedge on a roulette-style wheel.
struct WedgeView: View {
    
    /// The label that is displayed on the wedge.
    let label: String
    
    /// The central angle of the wedge.
    let angle: Angle
    
    /// The hue of the wedge’s background color.
    private let hue = Double.random(in: 0 ... 1)
    
    var body: some View {
        GeometryReader { geometry in
            CircularSector(angle: angle)
                .fill(backgroundGradient)
                .overlay(
                    Text(label)
                        .shadow(color: .black, radius: 4)
                        .offset(x: geometry.size.width / 4)
                        .rotationEffect(angle / 2)
                )
        }
    }
    
    /// The background gradient of the wedge.
    var backgroundGradient: AngularGradient {
        let startColor = Color(hue: hue, saturation: 0.4, brightness: 0.8)
        let endColor = Color(hue: hue, saturation: 0.7, brightness: 0.9)
        
        return AngularGradient(
            gradient: Gradient(colors: [startColor, endColor]),
            center: .center,
            angle: angle
        )
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
