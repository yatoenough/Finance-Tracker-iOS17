//
//  TransactionsForm.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI
import SwiftData

struct TransactionsForm: View {
    let transactionToEdit: TransactionModel?
    
    init(transactionToEdit: TransactionModel? = nil) {
        self.transactionToEdit = transactionToEdit
    }
    
    @State private var title: String = ""
    @State private var amountString: String = ""
    @State private var date: Date = .now
    @State private var type: TransactionType = .income
    
    @Environment(TransactionsViewModel.self) private var transactionsViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var isDisabled: Bool {
        title.isEmpty || amountString.isEmpty
    }
    
    var body: some View {
        Form {
            Section("Transaction details") {
                TextField("Title", text: $title)
                TextField("Amount", text: $amountString)
                    .keyboardType(.decimalPad)
                
                Picker("Transaction Type", selection: $type) {
                    ForEach(TransactionType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue.capitalized)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                
            }
            
            Section("Transaction date") {
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            
            Section {
                Button(transactionToEdit == nil ? "Add" : "Edit") {
                    var parsedAmount = Double(amountString) ?? 0
                    
                    if type == .expense {
                        parsedAmount *= -1
                    }
                    
                    let transaction = TransactionModel(title: title, amount: parsedAmount, date: date)
                    
                    if let transactionToEdit {
                        transactionsViewModel.editTransaction(transactionToEdit.id, transaction)
                        dismiss()
                        return
                    }
                    
                    transactionsViewModel.addTransaction(transaction)
                    dismiss()
                }
            }
            .disabled(isDisabled)
        }
        .navigationTitle(transactionToEdit == nil ? "Add Transaction" : "Edit Transaction")
        .onAppear {
            if let transactionToEdit {
                title = transactionToEdit.title
                amountString = String(format: "%.2f", abs(transactionToEdit.amount))
                date = transactionToEdit.date
                type = transactionToEdit.amount > 0 ? .income : .expense
            }
        }
    }
}

#Preview {
    DataPreview {
        NavigationStack {
            TransactionsForm()
        }
    }
}
