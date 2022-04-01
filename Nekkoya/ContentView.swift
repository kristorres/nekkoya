import SwiftUI

/// A view that renders the content of the app.
struct ContentView: View {
    var body: some View {
        CircularSector(angle: .degrees(90))
            .fill(Color.blue)
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
