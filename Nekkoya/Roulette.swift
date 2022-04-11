import SwiftUI

/// A view that renders a roulette-style wheel.
struct Roulette: View {
    
    /// Creates a roulette-style wheel with the given items.
    ///
    /// - Parameter items:       The items that are displayed on the wheel’s
    ///                          wedges.
    /// - Parameter onSpinStart: The action to perform when the wheel starts
    ///                          spinning.
    /// - Parameter onSpinEnd:   The action to perform when the wheel stops
    ///                          spinning. The closure takes the `title` of the
    ///                          chosen item as its sole argument.
    init(
        items: [RouletteItem],
        onSpinStart: @escaping () -> Void = {},
        onSpinEnd: @escaping (String) -> Void
    ) {
        self.items = items
        self.onSpinStart = onSpinStart
        self.onSpinEnd = onSpinEnd
    }
    
    /// The items that are displayed on the wheel’s wedges.
    private let items: [RouletteItem]
    
    /// The action to perform when the wheel starts spinning.
    private let onSpinStart: () -> Void
    
    /// The action to perform when the wheel stops spinning.
    private let onSpinEnd: (String) -> Void
    
    /// The angle offset as a result of spinning the wheel.
    @State private var spinAngle = Angle.zero
    
    /// Indicates whether the wheel is spinning.
    @State private var isSpinning = false
    
    var body: some View {
        GeometryReader { geometry in
            let radius = geometry.size.width / 2
            
            ZStack {
                ForEach(items.indices, id: \.self) { index in
                    Wedge(item: items[index], angle: wedgeAngle)
                        .rotationEffect(wedgeAngle * Double(index))
                }
                    .rotationEffect(spinAngle)
                
                Image(systemName: "arrowtriangle.up.fill")
                    .font(.system(size: radius / 8))
                    .foregroundColor(.black)
                    .offset(y: -radius / 3)
                
                spinButton(width: radius / 2)
            }
        }
    }
    
    /// The number of turns in a spin.
    private var turnCount: Double {
        return .random(in: Constants.minTurnCount ... Constants.maxTurnCount)
    }
    
    /// The central angle of each wedge on the wheel.
    private var wedgeAngle: Angle {
        .radians(.pi * 2) / Double(items.count)
    }
    
    /// Spins the wheel.
    ///
    /// If `isSpinning == true`, then this method will do nothing.
    private func spin() {
        if isSpinning {
            return
        }
        
        isSpinning = true
        onSpinStart()
        withAnimation(.easeOut(duration: Constants.spinTime)) {
            spinAngle += (.radians(.pi * 2) * turnCount)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.spinTime) {
            spinAngle.normalize()
            var chosenAngle = Double.pi * 1.5 - spinAngle.radians
            if chosenAngle < 0 {
                chosenAngle += (.pi * 2)
            }
            let chosenItemIndex = Int(floor(chosenAngle / wedgeAngle.radians))
            let chosenItemTitle = items[chosenItemIndex].title
            onSpinEnd(chosenItemTitle)
            isSpinning = false
        }
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
                .foregroundColor(isSpinning ? .clear : .white)
        }
            .onTapGesture(perform: spin)
    }
    
    /// An internal enum that contains constants.
    private enum Constants {
        static let spinTime = 10.0
        static let minTurnCount = 20.0
        static let maxTurnCount = 30.0
    }
}

#if DEBUG
struct Roulette_Previews: PreviewProvider {
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
        let rouletteItems = members.map {
            RouletteItem(title: $0, hue: .random(in: 0 ... 1))
        }
        
        return Roulette(items: rouletteItems) { _ in }
            .frame(width: 400, height: 400)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
