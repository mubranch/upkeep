//
//  UpkeepApp.swift
//  Upkeep
//
//  Created by Mustafa on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

@main
struct UpkeepApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
        }
        .modelContainer(for: [Appliance.self, Manual.self, Brand.self, Category.self]) { result in
            switch result {
            case .success(let success):
                addBrandsAndCategories(context: success.mainContext)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

func addBrandsAndCategories(context: ModelContext) {
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
