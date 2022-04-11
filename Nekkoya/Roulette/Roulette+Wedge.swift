import SwiftUI

extension Roulette {
    
    /// A view that renders a wedge on a roulette-style wheel.
    struct Wedge: View {
        
        /// The item that is displayed on the wedge.
        let item: RouletteItem
        
        /// The central angle of the wedge.
        let angle: Angle
        
        var body: some View {
            GeometryReader { geometry in
                let radius = geometry.size.width / 2
                
                CircularSector(angle: angle)
                    .fill(backgroundGradient)
                    .overlay(
                        HStack {
                            Spacer()
                            Text(item.title)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 4)
                                .padding(.trailing)
                        }
                            .frame(width: radius)
                            .offset(x: radius / 2)
                            .rotationEffect(angle / 2)
                    )
            }
        }
        
        /// The background gradient of the wedge.
        var backgroundGradient: AngularGradient {
            AngularGradient(
                gradient: Gradient(
                    colors: [
                        Color(hue: item.hue, saturation: 0.4, brightness: 0.8),
                        Color(hue: item.hue, saturation: 0.7, brightness: 0.9)
                    ]
                ),
                center: .center,
                angle: angle
            )
        }
    }
}

#if DEBUG
struct Roulette_Wedge_Previews: PreviewProvider {
    static var previews: some View {
        let item = RouletteItem(title: "Kris Torres", hue: 0.6)
        
        return Roulette.Wedge(item: item, angle: .degrees(90))
            .rotationEffect(.degrees(10))
            .frame(width: 400, height: 400)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
