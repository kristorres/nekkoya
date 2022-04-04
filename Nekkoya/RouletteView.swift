import SwiftUI

/// A view that renders a roulette-style wheel.
struct RouletteView: View {
    
    /// The labels of the items that are displayed on the wheel’s wedges.
    let items: [String]
    
    var body: some View {
        ZStack {
            ForEach(items.indices, id: \.self) { index in
                WedgeView(label: items[index], angle: wedgeAngle)
                    .rotationEffect(wedgeAngle * Double(index))
            }
        }
    }
    
    /// The central angle of each wedge on the wheel.
    private var wedgeAngle: Angle {
        .radians(.pi * 2) / Double(items.count)
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
