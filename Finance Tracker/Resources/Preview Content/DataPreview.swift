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
        
        for transaction in TransactionModel.demoTransactions {
            container.mainContext.insert(transaction)
        }
    }
}
