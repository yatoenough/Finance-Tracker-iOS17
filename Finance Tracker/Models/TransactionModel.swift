//
//  TransactionModel.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//


import SwiftUI
import SwiftData

@Model
class TransactionModel: @unchecked Sendable {
    var id: UUID = UUID()
    var title: String
    var amount: Double
    var date: Date
    
    init(title: String, amount: Double, date: Date) {
        self.title = title
        self.amount = amount
        self.date = date
    }
    
    static let demoTransactions: [TransactionModel] = [
        TransactionModel(title: "Test Transaction 1", amount: 100.0, date: Date()),
        TransactionModel(title: "Test Transaction 2", amount: -50.0, date: Date(timeIntervalSinceNow: -60)),
    ]
    
}
