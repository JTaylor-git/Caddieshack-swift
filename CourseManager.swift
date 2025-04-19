
import Foundation

class CourseManager {
    static func groupHolesByCourse(_ holes: [Hole]) -> [String: [Hole]] {
        Dictionary(grouping: holes, by: { $0.course })
    }

    static func sortedHoles(forCourse course: String, from holes: [Hole]) -> [Hole] {
        holes.filter { $0.course == course }.sorted { $0.holeNumber < $1.holeNumber }
    }

    static func searchCourses(query: String, from holes: [Hole]) -> [String] {
        let courses = Set(holes.map { $0.course })
        return courses.filter { $0.localizedCaseInsensitiveContains(query) }.sorted()
    }
}
