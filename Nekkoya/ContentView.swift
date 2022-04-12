import SwiftUI
import Urban

/// A view that renders the content of the app.
struct ContentView: View {
    
    /// The items that are displayed on the roulette.
    @State private var rouletteItems = [RouletteItem]()
    
    /// The input for the new item to add.
    @State private var newItemInput = ""
    
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
                itemInputSection
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
    
    /// The section where the user can input items into the roulette.
    private var itemInputSection: some View {
        VStack(spacing: 16) {
            Text("ITEMS").font(theme.typography.title)
            HStack(spacing: 16) {
                newItemTextField
                addNewItemButton
            }
            Divider()
            if rouletteItems.isEmpty {
                Text("No items added.")
                Spacer()
            }
            else {
                itemList
            }
        }
            .font(theme.typography.body)
            .padding()
            .frame(maxWidth: .infinity)
            .urbanPaper()
    }
    
    /// The button to add a new item to the roulette.
    private var addNewItemButton: some View {
        Button(action: addNewItem) {
            Image(systemName: "plus").font(theme.typography.header)
        }
            .buttonStyle(.urban(variant: .filled))
            .disabled(newItemInput.trimmed.isEmpty)
    }
    
    /// The scrollable list of items on the roulette.
    private var itemList: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16) {
                ForEach(rouletteItems) {
                    ItemRow(item: $0)
                }
            }
        }
    }
    
    /// The text field to input a new item.
    private var newItemTextField: some View {
        TextField("New Item", text: $newItemInput, onCommit: addNewItem)
            .textFieldStyle(.urban())
    }
    
    /// Adds a new item to the roulette.
    ///
    /// If the trimmed input is empty, then this method will do nothing.
    /// Otherwise, after completing this method, the *New Item* text field will
    /// be cleared out.
    private func addNewItem() {
        let newItemTitle = newItemInput.trimmed
        
        if newItemTitle.isEmpty {
            return
        }
        
        let hue = Double.random(in: 0 ... 1)
        rouletteItems.append(RouletteItem(title: newItemTitle, hue: hue))
        newItemInput = ""
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
