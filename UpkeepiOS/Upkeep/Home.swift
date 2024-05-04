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

            // Test view for populating data
//            Test()
//                .tabItem {
//                    Label("Test", systemImage: "testtube.2")
//                }
        }
    }
}

#Preview {
    Home()
        .modelContainer(DataController().previewContainer())
}
