//
//  GalleryView.swift
//  Upkeep
//
//  Created by Mustafa on 4/26/24.
//

import Foundation
import SwiftData
import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel: GalleryViewModel

    var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle(Copy.Gallery.pageTitle)
                .toolbar {
                    filterButton
                    addButton
                }
        }
    }

    private var mainContent: some View {
        List {
            ForEach($viewModel.filteredAppliances) { $appliance in
                NavigationLink {
                    ApplianceDetailView(viewModel:
                        ApplianceDetailViewModel(appliance: appliance, modelContext: viewModel.modelContext), togglePickerViewModel: TogglePickerViewModel(selectedBrand: $appliance.brand, selectedCategory: $appliance.category, modelContext: viewModel.modelContext))
                } label: {
                    GalleryItemView(viewModel:
                        GalleryItemViewModel(appliance: appliance))
                }
            }
            .onDelete(perform: viewModel.deleteAppliance)
        }
        .listStyle(.plain)
    }

    private var filterButton: some ToolbarContent {
        ToolbarItem {
            FilterView(viewModel:
                FilterViewModel(filteredAppliances: $viewModel.filteredAppliances, modelContext: viewModel.modelContext))
        }
    }

    private var addButton: some ToolbarContent {
        ToolbarItem {
            NavigationLink(destination: {
                GalleryQuickCreateView(viewModel:
                    GalleryQuickCreateViewModel(modelContext: viewModel.modelContext))
            }) {
                Label(Copy.Gallery.primaryActionLabel, systemImage: Copy.Gallery.primaryActionSymbol)
            }
        }
    }
}
