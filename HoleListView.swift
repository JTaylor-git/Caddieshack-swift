
import SwiftUI

struct HoleListView: View {
    let courseName: String
    let holes: [Hole]

    var body: some View {
        NavigationView {
            List(holes, id: \.id) { hole in
                NavigationLink(destination: SimulatedRoundView(pro: ProProfileLoader.loadProfiles().first!, hole: hole)) {
                    VStack(alignment: .leading) {
                        Text("Hole \(hole.holeNumber)").font(.headline)
                        Text("Tee: (\(hole.tee.latitude), \(hole.tee.longitude))")
                        Text("Pin: (\(hole.pin.latitude), \(hole.pin.longitude))")
                    }
                }
            }
            .navigationTitle(courseName)
        }
    }
}
