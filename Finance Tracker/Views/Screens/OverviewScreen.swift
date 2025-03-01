//
//  OverviewScreen.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 01/03/2025.
//

import SwiftUI

struct OverviewScreen: View {
    var body: some View {
        ScrollView {
            VStack {
                AmountBlock(title: "Current balance", amount: 200)
                AmountBlock(title: "Income", amount: 200)
                AmountBlock(title: "Expenses", amount: 0)
            }
            .padding()
        }
        
        .navigationTitle("Overview")
    }
}

#Preview {
    NavigationStack {
        OverviewScreen()
    }
}
