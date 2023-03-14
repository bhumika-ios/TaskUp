//
//  TaskUpApp.swift
//  TaskUp
//
//  Created by Bhumika Patel on 14/03/23.
//

import SwiftUI

@main
struct TaskUpApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
