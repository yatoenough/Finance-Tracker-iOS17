//
//  TransactionItem.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI

struct TransactionItem: View {
    let transaction: TransactionModel
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(transaction.title)
                        .bold()
                    Text(dateFormatter.string(from: transaction.date))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Text("$" + NumberFormatter.shared.format(transaction.amount))
                    .foregroundStyle(transaction.amount > 0 ? Color.green : Color.red)
                    .bold()
                
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.background.secondary)
        )
    }
}

#Preview {
    TransactionItem(transaction: TransactionModel(title: "Demo", amount: 200, date: .now))
}
