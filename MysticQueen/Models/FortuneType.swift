import Foundation

enum FortuneType: String, Codable, CaseIterable, Identifiable {
    case tarot
    case katina
    case angelCards    // melek fali
    case playingCards  // iskambil fali
    case lenormand
    case coffeeReading // kahve fali

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .tarot: return "Tarot"
        case .katina: return "Katina"
        case .angelCards: return "Melek Fali"
        case .playingCards: return "Iskambil Fali"
        case .lenormand: return "Lenormand"
        case .coffeeReading: return "Kahve Fali"
        }
    }

    var icon: String {
        switch self {
        case .tarot: return "suit.spade.fill"
        case .katina: return "rectangle.grid.2x2.fill"
        case .angelCards: return "sparkles"
        case .playingCards: return "suit.heart.fill"
        case .lenormand: return "leaf.fill"
        case .coffeeReading: return "cup.and.saucer.fill"
        }
    }

    var description: String {
        switch self {
        case .tarot: return "78 kartla hayatinin haritasini cikarir"
        case .katina: return "Eski cagan gizemli kartlari"
        case .angelCards: return "Meleklerden gelen mesajlar"
        case .playingCards: return "Klasik iskambil ile kader okuma"
        case .lenormand: return "36 kartla detayli hayat analizi"
        case .coffeeReading: return "Fincanindaki gizli semboller"
        }
    }
}
