import Foundation
import MapKit
import SQLite

struct HoleLocation: Identifiable, Decodable {
   let id: String
   let courseName: String
   let holeNumber: Int
   let feature: String
   let latitude: Double
   let longitude: Double
   let par: Int
   let yardage: Int

   var coordinate: CLLocationCoordinate2D {
       CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
   }
}

class HoleDBLoader: ObservableObject {
   @Published var holes: [HoleLocation] = []

   private var db: Connection?

   init(dbPath: String = Bundle.main.path(forResource: "optimized_data", ofType: "db") ?? "") {
       do {
           db = try Connection(dbPath)
           loadHoleCoordinates()
       } catch {
           print("[error] Failed to connect to DB: \(error)")
       }
   }

   private func loadHoleCoordinates() {
       guard let db = db else { return }

       let table = Table("holes")
       let uuid = Expression<String>("id")
       let course = Expression<String>("course")
       let hole = Expression<Int>("hole")
       let feature = Expression<String>("feature")
       let lat = Expression<Double>("latitude")
       let lon = Expression<Double>("longitude")
       let par = Expression<Int?>("par")
       let yardage = Expression<Int?>("yardage")

       do {
           for row in try db.prepare(table) {
               holes.append(HoleLocation(
                   id: row[uuid],
                   courseName: row[course],
                   holeNumber: row[hole],
                   feature: row[feature],
                   latitude: row[lat],
                   longitude: row[lon],
                   par: row[par] ?? 0,
                   yardage: row[yardage] ?? 0
               ))
           }
       } catch {
           print("[error] DB load failed: \(error)")
       }
   }
}
