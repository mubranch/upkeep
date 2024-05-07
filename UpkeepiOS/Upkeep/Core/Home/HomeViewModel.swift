//
//  HomeViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData

class HomeViewModel: ObservableObject {
    @Published var appliances: [Appliance]
    let modelContext: ModelContext
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "HomeViewModel")

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.appliances = modelContext.fetchData()
        logger.logInfo("Fetched appliances: \(appliances.count) items")
        addDefaultsIfNeeded()
    }

    private func addDefaultsIfNeeded() {
        if modelContext.isEmpty {
            for brand in DefaultBrands.allCases {
                modelContext.insert(Brand(name: brand.rawValue))
                logger.logInfo("Added default brand: \(brand.rawValue)")
            }

            for category in DefaultCategory.allCases {
                modelContext.insert(Category(title: category.rawValue))
                logger.logInfo("Added default category: \(category.rawValue)")
            }

            logger.logInfo("Defaults added to model context")
        } else {
            logger.logInfo("Model context already populated; no defaults added")
        }
    }
}
