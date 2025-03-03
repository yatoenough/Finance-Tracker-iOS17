//
//  AppTabView.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 03/03/2025.
//

import SwiftUI

enum AppTab {
    case overview
    case transactions
}

struct AppTabView: View {
    @State private var selectedTab: AppTab = .overview
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                OverviewScreen()
            }
            .tag(AppTab.overview)
            .tabItem {
                Label("Overview", image: "NavOverview")
            }
            
            NavigationStack {
                TransactionsScreen()
            }
            .tag(AppTab.transactions)
            .tabItem {
                Label("Transactions", image: "NavTransactions")
            }
            
        }
    }
}

#Preview {
    AppTabView()
}
