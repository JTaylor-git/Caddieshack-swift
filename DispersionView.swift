
import SwiftUI

struct DispersionView: View {
    @State private var golfer = GolferProfile(
        name: "John Doe",
        handicap: 12.5,
        clubStats: [
            ClubStat(club: "Driver", avgDistance: 260, missLeft: 20, missRight: 30, missLong: 15, missShort: 10, shotShape: "R"),
            ClubStat(club: "3 Wood", avgDistance: 240, missLeft: 15, missRight: 25, missLong: 10, missShort: 15, shotShape: "R"),
            ClubStat(club: "5 Wood", avgDistance: 225, missLeft: 12, missRight: 20, missLong: 12, missShort: 18, shotShape: "R"),
            ClubStat(club: "4 Iron", avgDistance: 200, missLeft: 10, missRight: 15, missLong: 10, missShort: 20, shotShape: "N")
        ]
    )
    
    var body: some View {
        NavigationView {
            VStack {
                Text("JD")
                    .font(.largeTitle)
                    .bold()
                Text(golfer.name)
                    .font(.title2)
                Text("Handicap: \(golfer.handicap, specifier: "%.1f")")
                    .foregroundColor(.gray)
                Text("Club Dispersion Data")
                    .font(.headline)
                    .padding(.top)

                Button("Edit") {
                    // future editable logic
                }
                .padding(.bottom, 5)

                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Club").bold().frame(width: 80, alignment: .leading)
                            Text("Avg").bold().frame(width: 50)
                            Text("Left").bold().frame(width: 50)
                            Text("Right").bold().frame(width: 50)
                            Text("Long").bold().frame(width: 50)
                            Text("Short").bold().frame(width: 50)
                            Text("Shape").bold().frame(width: 50)
                        }.padding(.horizontal)

                        Divider()

                        ForEach(golfer.clubStats) { stat in
                            HStack {
                                Text(stat.club).frame(width: 80, alignment: .leading)
                                Text("\(stat.avgDistance)").frame(width: 50)
                                Text("\(stat.missLeft)").frame(width: 50)
                                Text("\(stat.missRight)").frame(width: 50)
                                Text("\(stat.missLong)").frame(width: 50)
                                Text("\(stat.missShort)").frame(width: 50)
                                Text(stat.shotShape).frame(width: 50)
                            }.padding(.horizontal)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}
