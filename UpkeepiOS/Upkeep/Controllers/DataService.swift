//
//  DataService.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftData

enum DataService {
    private static var schema: Schema {
        Schema([Appliance.self, Manual.self, Brand.self, Category.self])
    }
    
    private static var previewConfiguration: ModelConfiguration {
        .init(isStoredInMemoryOnly: true)
    }
    
    private static var persistenConfiguration: ModelConfiguration {
        .init(isStoredInMemoryOnly: false)
    }
    
    static func addBrandsAndCategories(modelContext: ModelContext) {
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
    static func persistentContainer(_ container: ModelContainer? = nil, depth: Int = 0) -> ModelContainer {
        guard depth != 5 else {
            fatalError("Could not load model container.")
        }
        
        if container != nil {
            addBrandsAndCategories(modelContext: container!.mainContext)
            return container!
        }
        
        do {
            let container = try ModelContainer(for: schema, configurations: previewConfiguration)
            addBrandsAndCategories(modelContext: container.mainContext)
            return container
        } catch {
            print(error.localizedDescription + " trying \(5 - (depth + 1)) more times")
            return persistentContainer(depth: depth + 1)
        }
    }
    
    @MainActor
    static func previewContainer(_ container: ModelContainer? = nil, depth: Int = 0) -> ModelContainer {
        guard depth != 5 else {
            fatalError("Could not load model container.")
        }
        
        if container != nil {
            addBrandsAndCategories(modelContext: container!.mainContext)
            return container!
        }
        
        do {
            let container = try ModelContainer(for: schema, configurations: previewConfiguration)
            addBrandsAndCategories(modelContext: container.mainContext)
            return container
        } catch {
            print(error.localizedDescription + " trying \(5 - (depth + 1)) more times")
            return previewContainer(depth: depth + 1)
        }
    }
}
