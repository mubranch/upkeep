//
//  SettingsViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData

class SettingsViewModel: ObservableObject {
    let modelContext: ModelContext
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "SettingsViewModel")

    @Published var brands: [Brand] = []
    @Published var categories: [Category] = []

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchBrands()
        fetchCategories()
    }

    private func fetchBrands() {
        brands = modelContext.fetchData().sorted(by: { $0.name < $1.name })
        logger.logInfo("Brands fetched and sorted")
    }

    private func fetchCategories() {
        categories = modelContext.fetchData().sorted(by: { $0.title < $1.title })
        logger.logInfo("Categories fetched and sorted")
    }

    private func deleteModel<T: PersistentModel>(_ model: T) {
        modelContext.delete(model)
        logger.logInfo("Deleted model: \(String(describing: model))")
    }

    func deleteBrand(at indexSet: IndexSet) {
        for index in indexSet {
            guard brands.indices.contains(index) else {
                logger.logError("Invalid index for brand deletion: \(index)")
                continue
            }
            deleteModel(brands[index])
        }
        fetchBrands() // Refresh the brands array after deletion
    }

    func deleteCategory(at indexSet: IndexSet) {
        for index in indexSet {
            guard categories.indices.contains(index) else {
                logger.logError("Invalid index for category deletion: \(index)")
                continue
            }
            deleteModel(categories[index])
        }
        fetchCategories() // Refresh the categories array after deletion
    }
}
