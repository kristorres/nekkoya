import Foundation

/// An item on a roulette-style wheel.
struct RouletteItem: Identifiable {
    
    /// The ID of the item.
    let id = UUID()
    
    /// The title that is displayed on the item’s wedge.
    let title: String
    
    /// The hue of the item’s background color.
    let hue: Double
}
