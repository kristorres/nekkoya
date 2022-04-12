import Foundation

extension String {
    
    /// A version of the string that is stripped of whitespace and newline
    /// characters from both ends.
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
