//
//  OverviewScreen.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI
import SwiftData

struct OverviewScreen: View {
    @Query private var transactions: [TransactionModel]
    
    private var balanceViewModel: BalanceViewModel { .init(transactions: transactions) }
    
    var body: some View {
        ScrollView {
            VStack {
                AmountBlock(title: "Current balance", amount: balanceViewModel.balance)
                AmountBlock(title: "Income", amount: balanceViewModel.income)
                AmountBlock(title: "Expenses", amount: balanceViewModel.expenses)
            }
            .padding()
        }
        .onChange(of: transactions) { _, _ in
            print(transactions)
        }
        .navigationTitle("Overview")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddTransactionForm()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
}

#Preview {
    let modelContainer = try! ModelContainer(for: TransactionModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    NavigationStack {
        OverviewScreen()
    }
    .modelContainer(modelContainer)
    .environment(TransactionsViewModel(modelContext: ModelContext(modelContainer)))
}
