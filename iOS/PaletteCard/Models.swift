import Foundation

struct Mix: Identifiable, Codable, Equatable {
    var id: UUID
    var createdAt: Date
    var title: String
    var baseColors: String
    var medium: String
    var notes: String

    init(id: UUID = UUID(), createdAt: Date = Date(), title: String = "", baseColors: String = "", medium: String = "", notes: String = "") {
        self.id = id
        self.createdAt = createdAt
        self.title = title
        self.baseColors = baseColors
        self.medium = medium
        self.notes = notes
    }
}
