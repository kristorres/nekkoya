import SwiftUI
import Urban

/// A row that displays an item in the *Items* section.
struct ItemRow: View {
    
    /// The item to render.
    let item: RouletteItem
    
    /// The closure to set the title of the item on the roulette.
    let edit: (RouletteItem, String) -> Void
    
    /// The closure to remove the item from the roulette.
    let remove: (RouletteItem) -> Void
    
    /// Indicates whether the item is currently being edited.
    @State private var editModeIsEnabled = false
    
    /// The input for the new title.
    @State private var newTitleInput = ""
    
    /// The Urban theme.
    @Environment(\.urbanTheme) private var theme
    
    var body: some View {
        HStack {
            if editModeIsEnabled {
                editItemTextField
                cancelEditButton
                confirmEditButton
            }
            else {
                Text(item.title).font(theme.typography.body)
                Spacer()
                editItemButton
                removeItemButton
            }
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
    
    /// The button to cancel editing the item.
    private var cancelEditButton: some View {
        Button("Cancel") {
            editModeIsEnabled = false
        }
            .buttonStyle(.urban(variant: .filled, color: .secondary))
    }
    
    /// The button to confirm changes to the item.
    private var confirmEditButton: some View {
        Button("OK") {
            edit(item, newTitleInput.trimmed)
        }
            .buttonStyle(.urban(variant: .filled))
            .disabled(newTitleInput.trimmed.isEmpty)
    }
    
    /// The button to edit the item.
    private var editItemButton: some View {
        Button {
            editModeIsEnabled = true
            newTitleInput = item.title
        } label: {
            Image(systemName: "pencil").font(theme.typography.header)
        }
            .buttonStyle(.urban(variant: .filled))
    }
    
    /// The text field to edit the item.
    private var editItemTextField: some View {
        TextField("Item Name", text: $newTitleInput) {
            edit(item, newTitleInput.trimmed)
        }
            .textFieldStyle(.urban())
    }
    
    /// The button to remove the item from the roulette.
    private var removeItemButton: some View {
        Button(action: { remove(item) }) {
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
        
        return ItemRow(item: item, edit: { (_, _) in }, remove: { _ in })
            .frame(width: 400)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
