//
//  RAADApp.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

@main
struct RAADApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
