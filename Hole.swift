
import Foundation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

/* struct Shot: Codable {
   let latitude: Double
    let longitude: Double
}
*/

struct Hole: Identifiable, Codable {
    let id: UUID?
    let course: String
    let holeNumber: Int
    let tee: Location
    let pin: Location
    let targets: [Location]
}
