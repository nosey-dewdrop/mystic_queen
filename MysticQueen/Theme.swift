import SwiftUI

enum MQTheme {
    // MARK: - Background
    static let backgroundDark = Color(hex: 0x0D0D1A)
    static let backgroundCard = Color(hex: 0x151528)
    static let backgroundElevated = Color(hex: 0x1C1C35)

    // MARK: - Accent
    static let gold = Color(hex: 0xFFC875)
    static let goldLight = Color(hex: 0xFFE4B5)
    static let goldDim = Color(hex: 0xB8943F)

    // MARK: - Chat Bubbles
    static let bubbleCharacter = Color(hex: 0x2E2B59)
    static let bubbleUser = Color(hex: 0x1A3A4A)

    // MARK: - Character Ambiance Colors
    static let seleneAmbiance = Color(hex: 0x1A1A3E)    // deep indigo
    static let ruhiDedeAmbiance = Color(hex: 0x1A1408)   // warm dark brown
    static let lilithAmbiance = Color(hex: 0x0D0A14)     // near black purple
    static let nazimAmbiance = Color(hex: 0x0D1A1A)      // dark teal
    static let zumrutAnaAmbiance = Color(hex: 0x1A140D)  // warm amber dark
    static let cassianAmbiance = Color(hex: 0x0D141A)    // cool dark blue

    // MARK: - Text
    static let textPrimary = Color(hex: 0xFFF8E7)
    static let textSecondary = Color(hex: 0xB8B0A0)
    static let textMuted = Color(hex: 0x6B6360)

    // MARK: - Semantic
    static let coffee = Color(hex: 0xC4956A)
    static let error = Color(hex: 0xFF6B6B)
    static let success = Color(hex: 0x6BCB77)

    // MARK: - Fonts
    // Pixel font — ONLY for app logo/brand name
    static func pixelLogo(_ size: CGFloat = 12) -> Font {
        .custom("PressStart2P-Regular", size: size)
    }

    // Clean fonts for all UI text
    static func title(_ size: CGFloat = 22) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }

    static func heading(_ size: CGFloat = 17) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }

    static func body(_ size: CGFloat = 15) -> Font {
        .system(size: size, weight: .regular, design: .rounded)
    }

    static func caption(_ size: CGFloat = 13) -> Font {
        .system(size: size, weight: .medium, design: .rounded)
    }

    static func button(_ size: CGFloat = 15) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }

    // MARK: - Spacing
    static let paddingSmall: CGFloat = 8
    static let paddingMedium: CGFloat = 16
    static let paddingLarge: CGFloat = 24
    static let cornerRadius: CGFloat = 12
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
