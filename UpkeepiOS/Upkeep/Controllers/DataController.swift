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
    func persistentContainer(_ container: ModelContainer? = nil, depth: Int = 0) -> ModelContainer {
        guard depth != 5 else {
            fatalError("Could not load model container.")
        }
        
        if container != nil {
            addBrandsAndCategories(container: container!)
            return container!
        }
        
        do {
            let container = try ModelContainer(for: schema, configurations: previewConfiguration)
            addBrandsAndCategories(container: container)
            return container
        } catch {
            print(error.localizedDescription + " trying \(5 - (depth + 1)) more times")
            return persistentContainer(depth: depth + 1)
        }
    }

    @MainActor
    func previewContainer(_ container: ModelContainer? = nil, depth: Int = 0) -> ModelContainer {
        guard depth != 5 else {
            fatalError("Could not load model container.")
        }
        
        if container != nil {
            addBrandsAndCategories(container: container!)
            return container!
        }
        
        do {
            let container = try ModelContainer(for: schema, configurations: previewConfiguration)
            addBrandsAndCategories(container: container)
            return container
        } catch {
            print(error.localizedDescription + " trying \(5 - (depth + 1)) more times")
            return previewContainer(depth: depth + 1)
        }
    }
}
