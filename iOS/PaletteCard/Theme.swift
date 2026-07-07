import SwiftUI

/// Unique palette for Palette Card - Paint Mix Log — charcoal-plum studio wall with warm coral paint-swatch accent.
enum Theme {
    static let background = Color(hex: "#241417")
    static let surface = Color(hex: "#241417").opacity(0.001) == Color.clear ? Color(hex: "#241417") : Color(hex: "#241417")
    static let card = Color.white.opacity(0.06)
    static let accent = Color(hex: "#E0587A")
    static let accentSecondary = Color(hex: "#E8B23D")
    static let text = Color(hex: "#F7ECEA")
    static let textMuted = Color(hex: "#F7ECEA").opacity(0.6)

    static let titleFont: Font = .system(.title2, design: .serif).weight(.bold)
    static let headlineFont: Font = .system(.headline, design: .serif)
    static let bodyFont: Font = .system(.body, design: .serif)
    static let captionFont: Font = .system(.caption, design: .serif)

    static let cornerRadius: CGFloat = 16
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: 1)
    }
}
