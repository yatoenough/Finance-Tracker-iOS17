//
//  AddTransactionForm.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI
import SwiftData

struct AddTransactionForm: View {
    
    @State private var title: String = ""
    @State private var amountString: String = ""
    @State private var date: Date = .now
    
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
            }
            
            Section("Transaction date") {
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            
            Section {
                Button("Add") {
                    let transaction = TransactionModel(title: title, amount: Double(amountString) ?? 0, date: date)
                    transactionsViewModel.addTransaction(transaction)
                    dismiss()
                }
            }
            .disabled(isDisabled)
        }
        .navigationTitle("Add Transaction")
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: TransactionModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    
    NavigationStack {
        AddTransactionForm()
    }
    .modelContainer(modelContainer)
    .environment(TransactionsViewModel(modelContext: ModelContext(modelContainer)))
}
