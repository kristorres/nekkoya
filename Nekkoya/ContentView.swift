import SwiftUI
import Urban

/// A view that renders the content of the app.
struct ContentView: View {
    init() {
        let members = [
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
        
        self.rouletteItems = members.map {
            RouletteItem(title: $0, hue: .random(in: 0 ... 1))
        }
    }
    
    private let rouletteItems: [RouletteItem]
    
    /// The Urban theme.
    @Environment(\.urbanTheme) private var theme
    
    var body: some View {
        ZStack {
            theme.palette.background.main.ignoresSafeArea()
            
            HStack(spacing: Constants.rootStackSpacing) {
                Color.clear
                    .overlay(
                        Roulette(items: rouletteItems) { print($0) }
                            .scaledToFit()
                    )
                Color.clear
                    .urbanPaper()
            }
                .padding()
                .frame(
                    minWidth: Constants.minWindowWidth,
                    maxWidth: .infinity,
                    minHeight: Constants.minWindowHeight,
                    maxHeight: .infinity
                )
        }
    }
    
    /// An internal enum that contains constants.
    private enum Constants {
        static let minWindowWidth: CGFloat = 1200
        static let minWindowHeight: CGFloat = 600
        static let rootStackSpacing: CGFloat = 16
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.sizeThatFits)
    }
}
#endif
