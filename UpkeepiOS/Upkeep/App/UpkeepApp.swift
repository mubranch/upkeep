//
//  UpkeepApp.swift
//  Upkeep
//
//  Created by Mustafa on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

@main
struct UpkeepApp: App {
    var body: some Scene {
        let container = container
        let mainContext = container.mainContext

        WindowGroup {
            HomeView(viewModel: HomeViewModel(modelContext: mainContext))
        }
        .modelContainer(container)
    }

    let container: ModelContainer = {
        guard let container = try? ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: false)) else {
            fatalError("Failed to create model container.")
        }
        return container
    }()
}
