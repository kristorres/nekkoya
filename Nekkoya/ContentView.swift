import SwiftUI

/// A view that renders the content of the app.
struct ContentView: View {
    var body: some View {
        WedgeView(label: "Kris Torres", angle: .degrees(90))
            .rotationEffect(.degrees(10))
            .frame(width: 400, height: 400)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
