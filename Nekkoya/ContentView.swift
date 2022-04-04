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
        ZStack {
            ForEach(members.indices, id: \.self) { index in
                WedgeView(label: members[index], angle: wedgeAngle)
                    .rotationEffect(wedgeAngle * Double(index))
            }
        }
            .frame(width: 400, height: 400)
    }
    
    private var wedgeAngle: Angle {
        .radians(.pi * 2) / Double(members.count)
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
