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
    var modelContext: ModelContext

    @Binding var selectedCategory: Category?
    @Binding var selectedBrand: Brand?

    var brands: [Brand] {
        modelContext.fetchData().sorted(by: { $0.name < $1.name })
    }

    var categories: [Category] {
        modelContext.fetchData().sorted(by: { $0.title < $1.title })
    }

    var isBrandFilterDisabled: Bool {
        brands.isEmpty
    }

    var isCategoryFilterDisabled: Bool {
        categories.isEmpty
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
