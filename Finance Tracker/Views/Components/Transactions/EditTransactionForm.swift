//
//  EditTransactionForm.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 04/03/2025.
//

import SwiftUI
import SwiftData

struct EditTransactionForm: View {
    let transaction: TransactionModel
    
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
                Button("Edit") {
                    var parsedAmount = Double(amountString) ?? 0
                    
                    if type == .expense {
                        parsedAmount *= -1
                    }
                    
                    let editedTransaction = TransactionModel(title: title, amount: parsedAmount, date: date)
                    
                    transactionsViewModel.editTransaction(transaction.id, editedTransaction)
                    dismiss()
                }
            }
            .disabled(isDisabled)
        }
        .navigationTitle("Edit Transaction")
        .onAppear {
            title = transaction.title
            amountString = String(format: "%.2f", transaction.amount)
            date = transaction.date
            type = transaction.amount > 0 ? .income : .expense
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: TransactionModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    let transaction = TransactionModel(title: "Demo", amount: 200, date: .now)
    
    modelContainer.mainContext.insert(transaction)
    
    try? modelContainer.mainContext.save()
    
    return NavigationStack {
        EditTransactionForm(transaction: transaction)
    }
    .modelContainer(modelContainer)
    .environment(TransactionsViewModel(modelContext: ModelContext(modelContainer)))
}
