import SwiftUI
import MapKit

struct CourseMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.0528, longitude: -85.7247),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    @State private var hole = Hole(
        id: nil,
        course: "Sample",
        holeNumber: 1,
        tee: Location(latitude: 35.0528, longitude: -85.7247),
        pin: Location(latitude: 35.0532, longitude: -85.7229),
        targets: [Location(latitude: 35.0530, longitude: -85.7240)]
    )

    @State private var proShots: [Shot] = []
    @State private var userShots: [Shot] = []

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: markers) { marker in
            MapMarker(coordinate: marker.location, tint: marker.tint)
        }
        .onAppear {
            simulateProShot()
        }
        .overlay(
            VStack {
                Button("Add User Shot") {
                    let loc = CLLocationCoordinate2D(
                        latitude: hole.tee.latitude + Double.random(in: 0.0002...0.0006),
                        longitude: hole.tee.longitude + Double.random(in: 0.0002...0.0004)
                    )
                    userShots.append(Shot(
                        club: "7 Iron",
                        distance: Double.random(in: 150...170),
                        accuracy: "on_target",
                        location: loc,
                        timestamp: Date()
                    ))
                }
                .padding()
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .clipShape(Capsule())
            },
            alignment: .bottom
        )
        .navigationTitle("Hole \(hole.holeNumber) Map")
    }

    func simulateProShot() {
        guard let club = ProProfileLoader.loadProfiles().first?.clubs.first(where: { $0.club == "Driver" }) else {
            return
        }

        let teeCoord = CLLocationCoordinate2D(latitude: hole.tee.latitude, longitude: hole.tee.longitude)
        let shotCoord = ShotSimulator.simulateShot(from: teeCoord, using: club)

        proShots = [Shot(
            club: club.club,
            distance: club.avgCarry,
            accuracy: "on_target",
            location: shotCoord,
            timestamp: Date()
        )]
    }

    var markers: [Marker] {
        var list: [Marker] = [
            Marker(location: CLLocationCoordinate2D(latitude: hole.tee.latitude, longitude: hole.tee.longitude), label: "Tee", tint: .blue),
            Marker(location: CLLocationCoordinate2D(latitude: hole.pin.latitude, longitude: hole.pin.longitude), label: "Pin", tint: .green)
        ]
        for shot in proShots {
            list.append(Marker(location: shot.location, label: "Pro", tint: .white))
        }
        for shot in userShots {
            list.append(Marker(location: shot.location, label: "You", tint: .red))
        }
        return list
    }

    struct Marker: Identifiable {
        let id = UUID()
        let location: CLLocationCoordinate2D
        let label: String
        let tint: Color
    }
}
