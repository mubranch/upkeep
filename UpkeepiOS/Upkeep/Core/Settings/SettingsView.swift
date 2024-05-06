//
//  Settings.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Brands") {
                    ForEach(Array(viewModel.brands.prefix(5))) { brand in
                        Text(brand.name)
                    }

                    NavigationLink("More") {
                        BrandsView(viewModel: viewModel)
                    }
                }

                Section("Categories") {
                    ForEach(Array(viewModel.categories.prefix(5))) { category in
                        Text(category.title)
                    }

                    NavigationLink("More") {
                        CategoryView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle(Copy.Settings.pageTitle)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: false))

    return SettingsView(viewModel: SettingsViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
