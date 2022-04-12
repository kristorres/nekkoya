import SwiftUI
import Urban

/// A row that displays an item in the *Items* section.
struct ItemRow: View {
    
    /// The item to render.
    let item: RouletteItem
    
    /// The Urban theme.
    @Environment(\.urbanTheme) private var theme
    
    var body: some View {
        HStack {
            Text(item.title).font(theme.typography.body)
            Spacer()
            editItemButton
            removeItemButton
        }
            .padding()
            .urbanPaper(border: true, shadow: false)
    }
    
    /// The border “layer” of the item row.
    private var borderLayer: some View {
        RoundedRectangle(cornerRadius: theme.cornerRadius)
            .stroke(
                theme.palette.surface.content,
                lineWidth: Constants.borderWidth
            )
    }
    
    /// The button to edit the item.
    private var editItemButton: some View {
        Button(action: {}) {
            Image(systemName: "pencil").font(theme.typography.header)
        }
            .buttonStyle(.urban(variant: .filled))
    }
    
    /// The button to remove the item from the roulette.
    private var removeItemButton: some View {
        Button(action: {}) {
            Image(systemName: "xmark").font(theme.typography.header)
        }
            .buttonStyle(.urban(variant: .filled, color: .danger))
    }
    
    /// An internal enum that contains drawing constants.
    private enum Constants {
        static let borderWidth: CGFloat = 2
    }
}

#if DEBUG
struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        let item = RouletteItem(title: "Kris Torres", hue: 0.6)
        
        return ItemRow(item: item)
            .frame(width: 400)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
