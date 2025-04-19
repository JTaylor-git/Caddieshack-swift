import Foundation
import CoreLocation

class ShotSimulator {
    static func simulateShot(from start: CLLocationCoordinate2D, using clubStats: ProClubStats, windAdjustment: Double = 0.0) -> CLLocationCoordinate2D {
        let dispersionInDeg = clubStats.dispersionRadius / 121000.0
        let carryInDeg = (clubStats.avgCarry + windAdjustment) / 121000.0

        let angle = Double.random(in: 0..<2 * .pi)
        let offsetLat = carryInDeg * cos(angle)
        let offsetLon = dispersionInDeg * sin(angle)

        return CLLocationCoordinate2D(
            latitude: start.latitude + offsetLat,
            longitude: start.longitude + offsetLon
        )
    }

    static func simulatePro(for hole: Hole) -> [Shot] {
        guard let driver = ProProfileLoader.loadProfiles().first?.clubs.first(where: { $0.club == "Driver" }) else {
            return []
        }

        let startCoord = CLLocationCoordinate2D(latitude: hole.tee.latitude, longitude: hole.tee.longitude)
        let loc = simulateShot(from: startCoord, using: driver)

        return [Shot(
            club: "Driver",
            distance: driver.avgCarry,
            accuracy: "on_target",
            location: loc,
            timestamp: Date()
        )]
    }
}
