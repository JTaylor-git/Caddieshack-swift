// Views/HoleMapView.swift

import SwiftUI
import MapKit

struct HoleMapView: View {
    @StateObject private var loader = HoleDBLoader()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.5, longitude: -121.9),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: loader.holes) { point in
            MapAnnotation(coordinate: point.coordinate) {
                VStack(spacing: 2) {
                    ZStack {
                        Circle()
                            .fill(color(for: point.feature))
                            .frame(width: 10, height: 10)
                        Text(label(for: point.feature))
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                    if point.feature == "pin" {
                        Text("Par \(point.par), \(point.yardage) yds")
                            .font(.caption2)
                            .foregroundColor(.black)
                            .padding(4)
                            .background(Color.white.opacity(0.85))
                            .cornerRadius(4)
                    }
                }
            }
        }
        .overlay(Group {
            ForEach(generatePolylines(), id: \.self) { polyline in
                MapPolylineOverlay(polyline: polyline)
            }
        })
        .edgesIgnoringSafeArea(.all)
    }

    func label(for feature: String) -> String {
        switch feature.lowercased() {
        case "tee": return "T"
        case "pin": return "P"
        case "target": return "A"
        default: return "?"
        }
    }

    func color(for feature: String) -> Color {
        switch feature.lowercased() {
        case "tee": return .blue
        case "pin": return .red
        case "target": return .green
        default: return .gray
        }
    }
    
    struct CourseHoleKey: Hashable {
        let course: String
        let holeNumber: Int
    }
    func generatePolylines() -> [MKPolyline] {
        let grouped = Dictionary(grouping: loader.holes) {
            CourseHoleKey(course: $0.courseName,holeNumber: $0.holeNumber)
        }

        return grouped.values.map { features in
            let sorted = features.sorted {
                if $0.feature == "tee" { return true }
                if $0.feature == "target" && $1.feature == "pin" { return true }
                return false
            }
            let coords = sorted.map { $0.coordinate }
            return MKPolyline(coordinates: coords, count: coords.count)
        }
    }
}

struct MapPolylineOverlay: UIViewRepresentable {
    let polyline: MKPolyline

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.addOverlay(polyline)
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapPolylineOverlay
        init(_ parent: MapPolylineOverlay) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .orange
                renderer.lineWidth = 2
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
