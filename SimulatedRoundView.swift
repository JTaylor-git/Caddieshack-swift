import SwiftUI
import MapKit

struct SimulatedRoundView: View {
    let pro: ProProfile
    let hole: Hole

    var body: some View {
        VStack {
            Text("Hole \(hole.holeNumber): You vs. \(pro.name)")
                .font(.headline)
                .padding(.top)

            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: hole.tee.latitude, longitude: hole.tee.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            )), annotationItems: annotations) { point in
                MapMarker(coordinate: point.coordinate, tint: point.color)
            }
        }
    }

    private var annotations: [HoleMapPoint] {
        var markers: [HoleMapPoint] = [
            HoleMapPoint(label: "Tee", coordinate: CLLocationCoordinate2D(latitude: hole.tee.latitude, longitude: hole.tee.longitude), color: .green),
            HoleMapPoint(label: "Pin", coordinate: CLLocationCoordinate2D(latitude: hole.pin.latitude, longitude: hole.pin.longitude),
                         color: .red)
        ]

        if let club = pro.clubs.first(where: { $0.club == "Driver" }) {
    let proShot = ShotSimulator.simulateShot(from: CLLocationCoordinate2D(latitude: hole.tee.latitude, longitude:
                                                                            hole.tee.longitude), using: club)
            markers.append(HoleMapPoint(label: "\(pro.name) Drive", coordinate: proShot, color: .blue))
            
        }
        markers.append(HoleMapPoint(label: "Your Drive", coordinate: CLLocationCoordinate2D(latitude: hole.tee.latitude + 0.001, longitude: hole.tee.longitude + 0.001), color: .purple))
        return markers
        
    }
}

struct HoleMapPoint: Identifiable {
    let id = UUID()
    let label: String
    let coordinate: CLLocationCoordinate2D
    let color: Color
}
