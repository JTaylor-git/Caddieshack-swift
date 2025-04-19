
import Foundation
import CoreLocation

struct ProClubStats: Codable {
    let club: String
    let avgCarry: Double
    let dispersionRadius: Double  // in yards
}

struct ProProfile: Identifiable, Codable {
    let id: UUID
    let name: String
    let clubs: [ProClubStats]
}
