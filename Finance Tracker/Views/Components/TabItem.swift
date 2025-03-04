//
//  TabItem.swift
//  Finance Tracker
//
//  Created by Nikita Shyshkin on 04/03/2025.
//

import SwiftUI

struct TabItem<Content: View, Label: View>: View {
    let tag: AppTab
    let view: Content
    let label: Label
    
    init(tag: AppTab, @ViewBuilder view: () -> Content, @ViewBuilder label: () -> Label) {
        self.tag = tag
        self.view = view()
        self.label = label()
    }
    
    var body: some View {
        NavigationStack {
            view
        }
        .tag(tag)
        .tabItem {
            label
        }
    }
}
