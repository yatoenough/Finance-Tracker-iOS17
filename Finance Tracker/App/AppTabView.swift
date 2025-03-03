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
                Label("Overview", systemImage: "house.fill")
            }
            
            NavigationStack {
                TransactionsScreen()
            }
            .tag(AppTab.transactions)
            .tabItem {
                Label("Transactions", systemImage: "dollarsign")
            }
            
        }
    }
}

#Preview {
    AppTabView()
}
