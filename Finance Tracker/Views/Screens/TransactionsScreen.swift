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
            searchText.isEmpty ? transactions : transactions.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        TransactionsList(transactions: searchResults)
            .searchable(text: $searchText)
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: TransactionsForm()) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
    }
    
}

#Preview {
    let modelContainer = try! ModelContainer(for: TransactionModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    NavigationStack {
        TransactionsScreen()
    }
    .modelContainer(modelContainer)
    .environment(TransactionsViewModel(modelContext: modelContainer.mainContext))
}
