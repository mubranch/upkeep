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

            // Test View
            Test()
                .tabItem {
                    Label("Test", systemImage: "testtube.2")
                }
        }
    }
}

#Preview {
    Home()
        .modelContainer(for: [Appliance.self, Manual.self, Brand.self, Category.self], inMemory: false) { _ in
            debugPrint("Container is ready")
            let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
            let url = urlApp!.appendingPathComponent("default.store")
            if FileManager.default.fileExists(atPath: url.path) {
                print("swiftdata db at \(url.absoluteString)")
            }
        }
}
