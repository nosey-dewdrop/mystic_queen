import Foundation

struct Reading: Identifiable, Codable {
    let id: String
    let characterId: String
    let fortuneType: FortuneType
    let question: String
    let response: String
    let createdAt: Date
    var isFavorite: Bool

    init(
        id: String = UUID().uuidString,
        characterId: String,
        fortuneType: FortuneType,
        question: String,
        response: String,
        createdAt: Date = Date(),
        isFavorite: Bool = false
    ) {
        self.id = id
        self.characterId = characterId
        self.fortuneType = fortuneType
        self.question = question
        self.response = response
        self.createdAt = createdAt
        self.isFavorite = isFavorite
    }
}
