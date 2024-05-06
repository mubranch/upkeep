//
//  SettingsViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData

class SettingsViewModel: ObservableObject {
    var modelContext: ModelContext

    var brands: [Brand] {
        modelContext.fetchData().sorted(by: { $0.name < $1.name })
    }

    var categories: [Category] {
        modelContext.fetchData().sorted(by: { $0.title < $1.title })
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    private func deleteModel<T: PersistentModel>(_ model: T) {
        modelContext.delete(model)
    }

    func deleteBrand(_ indexSet: IndexSet) {
        _ = indexSet.map {
            deleteModel(brands[$0])
        }
    }

    func deleteCategory(_ indexSet: IndexSet) {
        _ = indexSet.map {
            deleteModel(categories[$0])
        }
    }
}
