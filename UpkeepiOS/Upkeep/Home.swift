//
//  ContentView.swift
//  Upkeep
//
//  Created by Mustafa on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

struct Home: View {
    @Environment(\.modelContext) var modelContext

    var body: some View {
        TabView {
            // Appliance gallery
            Gallery()
                .tabItem {
                    Label("Appliances", systemImage: "refrigerator")
                        .environment(\.symbolVariants, .none)
                }

            // Configuration Settings
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }.task {
            addBrandsAndCategories(context: modelContext)
        }
    }
}

#Preview {
    Home()
        .modelContainer(for: [Appliance.self, Manual.self, Brand.self, Category.self], inMemory: false)
}
