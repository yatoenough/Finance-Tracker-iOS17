//
//  AddTransactionForm.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI
import SwiftData

enum TransactionType: String, CaseIterable {
    case income
    case expense
}

struct AddTransactionForm: View {
    
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
                Button("Add") {
                    var parsedAmount = Double(amountString) ?? 0
                    
                    if type == .expense {
                        parsedAmount *= -1
                    }
                    
                    let transaction = TransactionModel(title: title, amount: parsedAmount, date: date)
                    
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
