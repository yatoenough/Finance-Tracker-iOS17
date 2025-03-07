//
//  TransactionsList.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 04/03/2025.
//

import SwiftUI
import SwiftData

struct TransactionsList: View {
    let transactions: [TransactionModel]
    
    @Environment(TransactionsViewModel.self) private var transactionsViewModel
    
    var body: some View {
        List {
            ForEach(transactions, id: \.id) { transaction in
                TransactionItem(transaction: transaction)
                    .transition(.opacity)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteTransaction(transaction)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        NavigationLink(destination: TransactionsForm(transactionToEdit: transaction)) {
                            Label("Edit", systemImage: "pencil")
                                .tint(.orange)
                        }
                    }
            }
            .onDelete { offsets in
                for offset in offsets {
                    deleteTransaction(transactions[offset])
                }
            }
        }
        .listStyle(.plain)
    }
    
    private func deleteTransaction(_ transaction: TransactionModel) {
        transactionsViewModel.deleteTransaction(transaction.id)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DataPreview {
        NavigationStack {
            TransactionsList(transactions: TransactionModel.demoTransactions)
        }
    }
}
