// CaddyCaddie/Views/ProfileView.swift
import SwiftUI

struct ProfileView: View {
    @AppStorage("golferName") var name: String = "John Doe"
    @AppStorage("handicap") var handicap: Double = 12.5

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Golfer Profile")) {
                    TextField("Name", text: $name)
                    Stepper(value: $handicap, in: -10...36, step: 0.1) {
                        Text("Handicap: \(handicap, specifier: "%.1f")")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
