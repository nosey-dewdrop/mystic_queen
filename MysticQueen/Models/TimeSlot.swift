import Foundation

struct TimeSlot: Identifiable, Hashable {
    let hour: Int      // 10-25 (25 = 01:30)
    let minute: Int    // 0 or 30
    var isOccupied: Bool

    var id: String { "\(hour):\(minute)" }

    var displayTime: String {
        let displayHour = hour >= 24 ? hour - 24 : hour
        return String(format: "%02d:%02d", displayHour, minute)
    }

    /// Generate all slots for a given day with fake occupancy based on daily seed
    static func generateSlots(for date: Date, characterId: String) -> [TimeSlot] {
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1
        let year = calendar.component(.year, from: date)

        // Deterministic seed from date + character
        var seedValue = dayOfYear * 31 + year * 7
        for char in characterId.unicodeScalars {
            seedValue = seedValue &+ Int(char.value)
        }

        var slots: [TimeSlot] = []

        // 10:00 to 01:30 → hours 10..25 (where 24=00:00, 25=01:00)
        for hour in 10...25 {
            for minute in stride(from: 0, to: 60, by: 30) {
                // Skip 01:30 (hour 25, minute 30) — last slot is 01:30
                if hour == 25 && minute == 30 { continue }

                // Deterministic fake occupancy: ~25-35% of slots appear taken
                let slotSeed = seedValue &* (hour * 60 + minute + 1)
                let isFakeOccupied = (slotSeed & 0x7FFFFFFF) % 100 < 30

                slots.append(TimeSlot(
                    hour: hour,
                    minute: minute,
                    isOccupied: isFakeOccupied
                ))
            }
        }

        return slots
    }
}
