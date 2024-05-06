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

    var brands: [Brand] {
        modelContext.fetchData().sorted(by: { $0.name < $1.name })
    }

    var categories: [Category] {
        modelContext.fetchData().sorted(by: { $0.title < $1.title })
    }

    var appliances: [Appliance] {
        modelContext.fetchData().sorted(by: { $0.name < $1.name })
    }

    var filterManager = FilterManager()
    let modelContext: ModelContext

    var filteredBrands: [Brand] {
        appliances.compactMap {
            if $0.brand != nil {
                return $0.brand!
            } else {
                return nil
            }
        }
    }

    func isActive(_ brand: Brand) -> Bool {
        filterManager.brands.contains(brand)
    }

    init(filteredAppliances: Binding<[Appliance]>,
         modelContext: ModelContext)
    {
        self._filteredAppliances = filteredAppliances
        self.modelContext = modelContext
    }

    func resetFilter() {
        filteredAppliances = appliances
        filterManager = filterManager.reset()
    }

    func updateFilter() {
        filteredAppliances = filterManager.filter(appliances: appliances)
    }

    func filter(for brand: Brand) {
        if filterManager.brands.contains(brand) {
            filterManager.brands.remove(brand)
        } else {
            filterManager.brands.insert(brand)
        }
    }
}
