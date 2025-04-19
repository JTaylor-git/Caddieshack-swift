
import SwiftUI

struct ProSelectionView: View {
    let profiles: [ProProfile]
    let onSelect: (ProProfile) -> Void

    var body: some View {
        List(profiles, id: \.id) { pro in
            Button(pro.name) {
                onSelect(pro)
            }
        }
        .navigationTitle("Select a Pro")
    }
}
