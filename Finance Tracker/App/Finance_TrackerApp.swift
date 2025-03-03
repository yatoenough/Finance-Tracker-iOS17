//
//  Finance_TrackerApp.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI
import SwiftData

@main
struct Finance_TrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TransactionModel.self,
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
            AppTabView()
        }
        .modelContainer(sharedModelContainer)
        .environment(TransactionsViewModel(modelContext: ModelContext(sharedModelContainer)))
    }
}
