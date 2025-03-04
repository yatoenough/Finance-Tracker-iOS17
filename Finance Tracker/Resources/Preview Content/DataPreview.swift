//
//  DataPreview.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 04/03/2025.
//

import SwiftUI
import SwiftData

struct DataPreview<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if let previewContainer {
            content
                .modelContainer(previewContainer)
                .environment(TransactionsViewModel(modelContext: previewContainer.mainContext))
                .onAppear {
                    preparePreviewData(container: previewContainer)
                }
        }
    }
    
    private func preparePreviewData(container: ModelContainer) {
        let transactions: [TransactionModel] = [
            TransactionModel(title: "Test Transaction 1", amount: 100.0, date: Date()),
            TransactionModel(title: "Test Transaction 2", amount: -50.0, date: Date(timeIntervalSinceNow: -60)),
        ]
        
        for transaction in transactions {
            container.mainContext.insert(transaction)
        }
    }
}
