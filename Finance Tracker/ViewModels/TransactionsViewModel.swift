//
//  TransactionsViewModel.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//


//
//  TransactionsViewModel.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 05/02/2025.
//

import Foundation
import SwiftData

@Observable
class TransactionsViewModel {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addTransaction(_ transaction: TransactionModel) {
        do {
            modelContext.insert(transaction)
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTransactionById(_ id: UUID) -> TransactionModel? {
        let fetchDescriptor = FetchDescriptor<TransactionModel>(predicate: #Predicate { transaction in
            transaction.id == id
        })
        
        do {
            let transactions: [TransactionModel] = try modelContext.fetch(fetchDescriptor)
            return transactions.first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func editTransaction(_ id: UUID, _ editedTransaction: TransactionModel) {
        guard let transactionToEdit = fetchTransactionById(id) else { return }
        transactionToEdit.title = editedTransaction.title
        transactionToEdit.amount = editedTransaction.amount
        transactionToEdit.date = editedTransaction.date
        
        try? modelContext.save()
    }
    
    func deleteTransaction(_ id: UUID) {
        guard let transactionToDelete = fetchTransactionById(id) else { return }
        modelContext.delete(transactionToDelete)
    }
}
