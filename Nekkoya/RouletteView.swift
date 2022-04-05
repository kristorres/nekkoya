import SwiftUI

/// A view that renders a roulette-style wheel.
struct RouletteView: View {
    
    /// Creates a roulette-style wheel with the given items.
    ///
    /// - Parameter items: The labels of the items that are displayed on the
    ///                    wheel’s wedges.
    init(items: [String]) {
        self.wedges = items.map {
            ($0, .random(in: 0 ... 1))
        }
    }
    
    /// The wedges on the wheel.
    private let wedges: [(label: String, hue: Double)]
    
    /// The angle offset as a result of spinning the wheel.
    @State private var spinAngle = Angle.zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(wedges.indices, id: \.self) { index in
                    WedgeView(
                        label: wedges[index].label,
                        angle: wedgeAngle,
                        hue: wedges[index].hue
                    )
                        .rotationEffect(wedgeAngle * Double(index))
                }
                    .rotationEffect(spinAngle)
                
                spinButton(width: geometry.size.width / 4)
            }
        }
    }
    
    /// The central angle of each wedge on the wheel.
    private var wedgeAngle: Angle {
        .radians(.pi * 2) / Double(wedges.count)
    }
    
    /// Returns a button that spins the wheel.
    ///
    /// - Parameter width: The width of the button.
    ///
    /// - Returns: The button.
    private func spinButton(width: CGFloat) -> some View {
        ZStack {
            Circle()
                .fill(.black)
                .frame(width: width)
            Text("SPIN")
                .font(.system(size: width / 4, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
            .onTapGesture {
                withAnimation(.easeOut(duration: 10)) {
                    spinAngle += .radians(.pi * 2) * .random(in: 20 ... 30)
                }
            }
    }
}

#if DEBUG
struct RouletteView_Previews: PreviewProvider {
    private static let members = [
        "Kwon Eun-bi",
        "Miyawaki Sakura",
        "Kang Hye-won",
        "Choi Ye-na",
        "Lee Chae-yeon",
        "Kim Chae-won",
        "Kim Min-ju",
        "Yabuki Nako",
        "Honda Hitomi",
        "Jo Yu-ri",
        "An Yu-jin",
        "Jang Won-young"
    ]
    
    static var previews: some View {
        RouletteView(items: members)
            .frame(width: 400, height: 400)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
