// CaddyCaddie/Models/Golfer.swift
import Foundation

struct Golfer: Codable {
    var name: String
    var handicap: Double
    var clubs: [Club]
}
