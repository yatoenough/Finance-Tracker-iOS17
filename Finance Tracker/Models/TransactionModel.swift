//
//  TransactionModel.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//


import SwiftUI
import SwiftData

@Model
class TransactionModel {
    var id: UUID = UUID()
    var title: String
    var amount: Double
    var date: Date
    
    init(title: String, amount: Double, date: Date) {
        self.title = title
        self.amount = amount
        self.date = date
    }
    
}
