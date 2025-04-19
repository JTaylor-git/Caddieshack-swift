// CaddyCaddie/Models/Shot.swift
import Foundation
import CoreLocation

struct Shot: Identifiable, Codable {
    var id: UUID = UUID()
    var club: String
    var distance: Double
    var accuracy: String // "on_target", "left", "right"
    var location: CLLocationCoordinate2D
    var timestamp: Date
}

