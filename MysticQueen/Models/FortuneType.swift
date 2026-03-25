import Foundation

enum FortuneType: String, Codable, CaseIterable, Identifiable {
    case tarot
    case katina
    case angelCards
    case playingCards
    case lenormand
    case coffeeReading

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .tarot: return "Tarot"
        case .katina: return "Katina"
        case .angelCards: return "Melek Falı"
        case .playingCards: return "İskambil Falı"
        case .lenormand: return "Lenormand"
        case .coffeeReading: return "Kahve Falı"
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
        case .tarot: return "78 kartla hayatının haritasını çıkarır"
        case .katina: return "Eski çağın gizemli kartları"
        case .angelCards: return "Meleklerden gelen mesajlar"
        case .playingCards: return "Klasik iskambil ile kader okuma"
        case .lenormand: return "36 kartla detaylı hayat analizi"
        case .coffeeReading: return "Fincanındaki gizli semboller"
        }
    }
}
