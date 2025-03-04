//
//  PreviewContainer.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 04/03/2025.
//

import SwiftData

let previewContainer: ModelContainer? = {
    let schema = Schema([
        TransactionModel.self,
    ])
    
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        print(error.localizedDescription)
    }
    
    return nil
}()
