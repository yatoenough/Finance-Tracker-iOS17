//
//  AmountBlock.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI

struct AmountBlock: View {
    let title: String
    let amount: Double
    
    private var formattedAmount: String {
        NumberFormatter.shared.format(amount)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.callout)
                    
                    Text("$" + formattedAmount)
                        .font(.title)
                        .bold()
                }
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.background.secondary)
        )
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AmountBlock(title: "Demo", amount: 2000)
}
