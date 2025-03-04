//
//  AppTabView.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 03/03/2025.
//

import SwiftUI
import SwiftData

enum AppTab {
    case overview
    case transactions
}

struct AppTabView: View {
    @State private var selectedTab: AppTab = .overview
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TabItem(tag: .overview) {
                OverviewScreen()
            } label: {
                Label("Overview", image: "NavOverview")
            }
            
            TabItem(tag: .transactions) {
                TransactionsScreen()
            } label: {
                Label("Transactions", image: "NavTransactions")
            }
            
        }
    }
}

#Preview {
    DataPreview {
        AppTabView()
    }
}
