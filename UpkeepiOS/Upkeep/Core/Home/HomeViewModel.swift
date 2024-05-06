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

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.appliances = modelContext.fetchData()
        addDefaults(context: modelContext)
    }

    // Adds default brands and categories to modelcontext
    func addDefaults(context: ModelContext) {
        if context.isEmpty {
            for item in DefaultBrand.allCases {
                context.insert(Brand(name: item.rawValue))
            }

            for item in DefaultCategory.allCases {
                context.insert(Category(title: item.rawValue))
            }

            print("Defaults added to container")
        }
    }
}
