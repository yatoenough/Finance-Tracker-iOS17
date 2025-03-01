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
    
    private var incomeTransactions: [TransactionModel] {
        transactions.filter({ $0.amount > 0 })
    }
    
    private var expenseTransactions: [TransactionModel] {
        transactions.filter({ $0.amount < 0 })
    }
    
    private var income: Double {
        incomeTransactions.reduce(0) { $0 + $1.amount }
    }
    
    private var expenses: Double {
        expenseTransactions.reduce(0) { $0 + abs($1.amount) }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AmountBlock(title: "Current balance", amount: income - expenses)
                AmountBlock(title: "Income", amount: income)
                AmountBlock(title: "Expenses", amount: expenses)
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
