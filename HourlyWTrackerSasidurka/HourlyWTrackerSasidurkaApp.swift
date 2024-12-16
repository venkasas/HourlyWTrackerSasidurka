//
//  HourlyWTrackerSasidurkaApp.swift
//  HourlyWTrackerSasidurka
//
//  Created by Sasidurka on 2024-12-16.
//

import SwiftUI

@main
struct HourlyWTrackerSasidurkaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
