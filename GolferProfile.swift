
import Foundation

struct ClubStat: Identifiable, Codable {
    var id: UUID = UUID()
    var club: String
    var avgDistance: Int
    var missLeft: Int
    var missRight: Int
    var missLong: Int
    var missShort: Int
    var shotShape: String  // e.g., "R", "L", "N"
}

struct GolferProfile: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var handicap: Double
    var clubStats: [ClubStat]
}

