import SwiftUI

/// A view that renders the content of the app.
struct ContentView: View {
    private let members = [
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
    
    var body: some View {
        HStack(spacing: Constants.rootStackSpacing) {
            Color.clear
                .overlay(
                    RouletteView(items: members) { print($0) }
                        .scaledToFit()
                )
            Color.clear
        }
            .padding()
            .frame(
                minWidth: Constants.minWindowWidth,
                maxWidth: .infinity,
                minHeight: Constants.minWindowHeight,
                maxHeight: .infinity
            )
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
