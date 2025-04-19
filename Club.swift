// CaddyCaddie/Models/Club.swift
import Foundation
import CoreLocation

struct Club: Codable {
    var id: UUID = UUID()
    var distance: Double
    var club: String
    var coordinates: CLLocationCoordinate2D
}

