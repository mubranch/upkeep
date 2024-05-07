//
//  FilterViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

class FilterViewModel: ObservableObject {
    @Binding var filteredAppliances: [Appliance]
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "FilterViewModel")

    private(set) var brands: [Brand] = []
    private(set) var categories: [Category] = []
    private(set) var appliances: [Appliance] = []

    var filterManager = FilterManager()
    let modelContext: ModelContext

    var filteredBrands: [Brand] {
        Set(appliances.compactMap { $0.brand }).sorted(by: { $0.name < $1.name })
    }

    init(filteredAppliances: Binding<[Appliance]>, modelContext: ModelContext) {
        self._filteredAppliances = filteredAppliances
        self.modelContext = modelContext
        loadData()
    }

    private func loadData() {
        brands = modelContext.fetchData().sorted(by: { $0.name < $1.name })
        categories = modelContext.fetchData().sorted(by: { $0.title < $1.title })
        appliances = modelContext.fetchData().sorted(by: { $0.name < $1.name })
        logger.logInfo("Data loaded and sorted")
    }

    func resetFilter() {
        filteredAppliances = appliances
        filterManager = FilterManager()
        logger.logInfo("Filter reset to default")
    }

    func updateFilter() {
        filteredAppliances = filterManager.filter(appliances: appliances)
        logger.logInfo("Filter updated")
    }

    func filter(for brand: Brand) {
        if filterManager.brands.contains(brand) {
            filterManager.brands.remove(brand)
        } else {
            filterManager.brands.insert(brand)
        }
        updateFilter()
        logger.logInfo("Filter toggled for brand: \(brand.name)")
    }
}
