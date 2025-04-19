
import Foundation

class ProProfileLoader {
    static func loadProfiles() -> [ProProfile] {
        guard let url = Bundle.main.url(forResource: "pro_profiles", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let profiles = try? JSONDecoder().decode([ProProfile].self, from: data) else {
            return []
        }
        return profiles
    }
}
