//
//  ToggleViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

class TogglePickerViewModel: ObservableObject {
    let modelContext: ModelContext
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "TogglePickerViewModel")

    @Binding var selectedCategory: Category?
    @Binding var selectedBrand: Brand?

    var brands: [Brand] {
        let fetchedBrands: [Brand] = modelContext.fetchData().sorted(by: { $0.name < $1.name })
        logger.logInfo("Fetched and sorted brands: \(fetchedBrands.count) items.")
        return fetchedBrands
    }

    var categories: [Category] {
        let fetchedCategories: [Category] = modelContext.fetchData().sorted(by: { $0.title < $1.title })
        logger.logInfo("Fetched and sorted categories: \(fetchedCategories.count) items.")
        return fetchedCategories
    }

    var isBrandFilterDisabled: Bool {
        let disabled = brands.isEmpty
        logger.logInfo("Brand filter is \(disabled ? "disabled" : "enabled")")
        return disabled
    }

    var isCategoryFilterDisabled: Bool {
        let disabled = categories.isEmpty
        logger.logInfo("Category filter is \(disabled ? "disabled" : "enabled")")
        return disabled
    }

    init(
        selectedBrand: Binding<Brand?>,
        selectedCategory: Binding<Category?>,
        modelContext: ModelContext)
    {
        self.modelContext = modelContext
        self._selectedBrand = selectedBrand
        self._selectedCategory = selectedCategory
    }
}
