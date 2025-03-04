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
            VStack(spacing: 15) {
                VStack {
                    AmountBlock(title: "Current balance", amount: balanceViewModel.balance)
                    AmountBlock(title: "Income", amount: balanceViewModel.income)
                    AmountBlock(title: "Expenses", amount: balanceViewModel.expenses)
                }
                
                VStack() {
                    HStack {
                        Text("Transactions")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                    }
                    
                    ForEach(transactions.prefix(5), id: \.id) { transaction in
                        TransactionItem(transaction: transaction)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Overview")
    }
    
}

#Preview {
    DataPreview {
        NavigationStack {
            OverviewScreen()
        }
    }
}
