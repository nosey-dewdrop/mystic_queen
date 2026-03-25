import Foundation

struct Appointment: Identifiable, Codable {
    let id: String
    let characterId: String
    let slotDate: Date       // the date of the appointment
    let slotHour: Int        // 10-25 (10:00 to 01:30, where 24=00:00, 25=01:30)
    let slotMinute: Int      // 0 or 30
    var isExtended: Bool     // whether user extended +10min
    var status: AppointmentStatus
    let createdAt: Date

    init(
        id: String = UUID().uuidString,
        characterId: String,
        slotDate: Date,
        slotHour: Int,
        slotMinute: Int,
        isExtended: Bool = false,
        status: AppointmentStatus = .scheduled,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.characterId = characterId
        self.slotDate = slotDate
        self.slotHour = slotHour
        self.slotMinute = slotMinute
        self.isExtended = isExtended
        self.status = status
        self.createdAt = createdAt
    }

    var displayTime: String {
        let displayHour = slotHour >= 24 ? slotHour - 24 : slotHour
        return String(format: "%02d:%02d", displayHour, slotMinute)
    }
}

enum AppointmentStatus: String, Codable {
    case scheduled
    case inProgress
    case completed
    case cancelled
}
