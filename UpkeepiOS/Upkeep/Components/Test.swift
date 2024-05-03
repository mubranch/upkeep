//
//  TestView.swift
//  Upkeep
//
//  Created by Mustafa on 5/1/24.
//

import Foundation
import SwiftData
import SwiftUI

struct Test: View {
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List {
                Button("Reset", systemImage: "arrow.circlepath") {
                    self.modelContext.container.deleteAllData()
                    DataService.addBrandsAndCategories(modelContext: self.modelContext)
                }.disabled(modelContext.isEmpty)

                Button("Populate", systemImage: "swiftdata") {
                    Task { @MainActor in
                        let fetchRequest = FetchDescriptor<Category>()
                        let categories = (try? self.modelContext.fetch(fetchRequest)) ?? []

                        let fetchRequest2 = FetchDescriptor<Brand>()
                        let brands = (try? self.modelContext.fetch(fetchRequest2)) ?? []

                        for num in 0 ... Int.random(in: 0 ... 3) {
                            if let category = categories.randomElement(),
                               let brand = brands.randomElement()
                            {
                                let appliance = Appliance(name: "\(brand.name) \(category.title)",
                                                          category: category,
                                                          brand: brand,
                                                          modelNumber: "\(Int.random(in: 111111 ... 99999999))")

                                self.modelContext.insert(appliance)

                                if num % 2 == 0 {
                                    if let url = URL(string: "https://data2.manualslib.com/pdf7/330/32906/3290542-kitchenaid/krmf706ess.pdf?601e6ae19ee52c55d34e84d5d4616ea8"), let file = try? Data(contentsOf: url) {
                                        let manual = Manual(name: "\(appliance.name) \(appliance.id) Manual", type: "Manual", file: file)
                                        self.modelContext.insert(manual)
                                        manual.appliance = appliance
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Preview Controller")
        }
    }
}
