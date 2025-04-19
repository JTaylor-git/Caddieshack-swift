
import Foundation

class HoleLoader {
    static func loadHoles() -> [Hole] {
        guard let url = Bundle.main.url(forResource: "enhanced_holes", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let holes = try? JSONDecoder().decode([Hole].self, from: data) else {
            return []
        }
        return holes
    }
}
