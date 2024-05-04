//
//  DataController.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftData

struct DataController {
    var schema: Schema {
        Schema([Appliance.self, Manual.self, Brand.self, Category.self])
    }
    
    var previewConfiguration: ModelConfiguration = .init(isStoredInMemoryOnly: true)
    var persistenConfiguration: ModelConfiguration = .init(isStoredInMemoryOnly: false)
    
    @MainActor
    func previewContainer() -> ModelContainer {
        return createContainerWithRetry(configuration: previewConfiguration)
    }
    
    @MainActor
    func persistentContainer() -> ModelContainer {
        return createContainerWithRetry(configuration: persistenConfiguration)
    }
    
    @MainActor
    func addBrandsAndCategories(container: ModelContainer) {
        let modelContext = container.mainContext
        
        if modelContext.isEmpty {
            for item in DefaultBrand.allCases {
                modelContext.insert(Brand(name: item.rawValue))
            }
            
            for item in DefaultCategory.allCases {
                modelContext.insert(Category(title: item.rawValue))
            }
            
            print("Defaults added to container")
        }
    }

    @MainActor
    func createContainerWithRetry(_ container: ModelContainer? = nil, configuration: ModelConfiguration, depth: Int = 0) -> ModelContainer {
        guard depth != 5 else {
            fatalError("Could not load model container.")
        }
        
        if container != nil {
            addBrandsAndCategories(container: container!)
            return container!
        }
        
        do {
            let container = try ModelContainer(for: schema, configurations: persistenConfiguration)
            addBrandsAndCategories(container: container)
            return container
        } catch {
            print(error.localizedDescription + " trying \(5 - (depth + 1)) more times")
            return createContainerWithRetry(configuration: configuration, depth: depth + 1)
        }
    }
}
