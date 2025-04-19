import SwiftUI

struct MainTabView: View {
   @State private var expanded = false

   var body: some View {
    NavigationView {
                List {
                    NavigationLink("Profile", destination: ProfileView())
                    NavigationLink("Dispersion", destination: DispersionView())
                    NavigationLink("Yardage Book", destination: HoleMapView())
                    NavigationLink("Course Map", destination: ContentView())
                    NavigationLink("AI Caddy", destination: CaddyChatView())
                }
                .navigationTitle("Caddyshack")
            
               .transition(.move(edge: .top))
               .padding(.top)
           }

           Button(action: {
               withAnimation { expanded.toggle() }
           }) {
               Label("Menu", systemImage: expanded ? "chevron.up" : "chevron.down")
                   .padding()
                   .background(Color.blue.opacity(0.1))
                   .cornerRadius(8)
                
           }
   }
}
