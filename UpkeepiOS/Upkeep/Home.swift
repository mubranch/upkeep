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
    var body: some View {
        TabView {
            // Appliances
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

            // Test By Populating Data
            Test()
                .tabItem {
                    Label("Test", systemImage: "testtube.2")
                }
        }
    }
}

#Preview {
    Home()
        .modelContainer(DataService.previewContainer())
}
