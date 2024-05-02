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
    @Query private var manuals: [Manual]
    @Query private var appliances: [Appliance]
    @Environment(\.modelContext) private var modelContext

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
        .modelContainer(for: [Appliance.self, Manual.self]) { result in
            debugPrint("Container is ready")
            print(result)
            let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
            let url = urlApp!.appendingPathComponent("default.store")
            if FileManager.default.fileExists(atPath: url.path) {
                print("swiftdata db at \(url.absoluteString)")
            }
        }
}
