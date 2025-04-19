
import SwiftUI

struct CourseListView: View {
    let courses: [String]
    let onSelect: (String) -> Void

    var body: some View {
        NavigationView {
            List(courses, id: \.self) { course in
                Button(course) {
                    onSelect(course)
                }
            }
            .navigationTitle("Courses")
        }
    }
}
