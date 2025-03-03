//
//  TransactionsScreen.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 03/03/2025.
//

import SwiftUI
import SwiftData

struct TransactionsScreen: View {
    @State private var searchText: String = ""
    
    @Query private var transactions: [TransactionModel]
    
    var searchResults: [TransactionModel] {
        withAnimation {
            searchText.isEmpty ? transactions : transactions.filter { $0.title.contains(searchText) }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(searchResults, id: \.id) { transaction in
                    TransactionItem(transaction: transaction)
                        .transition(.opacity)
                }
            }
            .searchable(text: $searchText)
            .padding()
        }
        .navigationTitle("Transactions")
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: TransactionModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    NavigationStack {
        TransactionsScreen()
    }
    .modelContainer(modelContainer)
    .environment(TransactionsViewModel(modelContext: ModelContext(modelContainer)))
}
