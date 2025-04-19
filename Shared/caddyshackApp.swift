//
//  caddyshackApp.swift
//  Shared
//
//  Created by JBT on 4/15/25.
//

import SwiftUI

@main
struct caddyshackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
