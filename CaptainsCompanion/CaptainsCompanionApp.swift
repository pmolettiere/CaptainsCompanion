//
//  CaptainsCompanionApp.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
//

import SwiftUI
import SwiftData

@main
struct CaptainsCompanionApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Vessel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            VesselListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
