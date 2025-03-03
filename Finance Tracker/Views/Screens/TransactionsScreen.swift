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
    
    @Environment(TransactionsViewModel.self) private var transactionsViewModel
    
    @Query private var transactions: [TransactionModel]
    
    var searchResults: [TransactionModel] {
        withAnimation {
            searchText.isEmpty ? transactions : transactions.filter { $0.title.contains(searchText) }
        }
    }
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.id) { transaction in
                TransactionItem(transaction: transaction)
                    .transition(.opacity)
            }
            .onDelete(perform: deleteTransactions)
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
        .navigationTitle("Transactions")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddTransactionForm()) {
                    Text("Transaction")
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    private func deleteTransactions(at offsets: IndexSet) {
        for offset in offsets {
            let id = transactions[offset].id
            transactionsViewModel.deleteTransaction(id)
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
