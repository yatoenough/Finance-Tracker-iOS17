//
//  BalanceViewModel.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import Foundation

@Observable
class BalanceViewModel {
    private let transactions: [TransactionModel]
    
    init(transactions: [TransactionModel]) {
        self.transactions = transactions
    }
    
    var balance: Double {
        income - expenses
    }
    
    var income: Double {
        incomeTransactions.reduce(0) { $0 + $1.amount }
    }
    
    var expenses: Double {
        expenseTransactions.reduce(0) { $0 + abs($1.amount) }
    }
    
    private var incomeTransactions: [TransactionModel] {
        transactions.filter({ $0.amount > 0 })
    }
    
    private var expenseTransactions: [TransactionModel] {
        transactions.filter({ $0.amount < 0 })
    }
}
