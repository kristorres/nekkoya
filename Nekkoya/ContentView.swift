import SwiftUI

/// A view that renders the content of the app.
struct ContentView: View {
    var body: some View {
        CircularSector(angle: .degrees(90), offset: .degrees(10))
            .fill(Color.blue)
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
