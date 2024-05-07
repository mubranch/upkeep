//
//  GalleryQuickCreateView.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftData
import SwiftUI

struct GalleryQuickCreateView: View {
    @Environment(\.editMode) var editMode

    @StateObject var viewModel: GalleryQuickCreateViewModel

    var body: some View {
        ZStack {
            if viewModel.isFetchingData {
                ProgressView()
            } else {
                content
                    .navigationTitle("Quick Create")
                    .onChange(of: viewModel.shouldDismiss, viewModel.dismiss)
                    .toolbar {
                        testButton
                        searchButton
                    }
                    .fullScreenCover(item: $viewModel.newAppliance, onDismiss: viewModel.dismiss) { appliance in
                        @Bindable var appliance = appliance
                        ApplianceDetailView(viewModel: ApplianceDetailViewModel(appliance: appliance, modelContext: viewModel.modelContext, isNewModel: true), togglePickerViewModel: TogglePickerViewModel(selectedBrand: $appliance.brand, selectedCategory: $appliance.category, modelContext: viewModel.modelContext))
                    }
            }
        }
    }

    var content: some View {
        List {
            Section {
                TextField(Copy.QuickCreate.modelNumberPrompt, text: $viewModel.modelNumber)

                LabeledContent(Copy.QuickCreate.brandPickerMenuLabel) {
                    Menu(viewModel.brand?.name ?? Copy.QuickCreate.brandPickerPlaceholder) {
                        ForEach(viewModel.brands, id: \.rawValue) { b in
                            Button(b.name) {
                                viewModel.brand = b
                            }.tag(b)
                        }
                    }
                }
            }

            Section("Advanced") {
                // Category toggle picker
                LabeledContent(Copy.Appliance.typeLabel) {
                    CategoryTogglePicker(viewModel:
                        TogglePickerViewModel(selectedBrand: $viewModel.brand, selectedCategory: $viewModel.category, modelContext: viewModel.modelContext))
                }

                LabeledContent(Copy.Appliance.serialNumberLabel) {
                    ToggleTextField(viewModel:
                        ToggleTextFieldViewModel(text: $viewModel.serialNumber))
                }

                // Dates related to appliance maintenance and warranty
                LabeledContent(Copy.Appliance.lastMaintenanceLabel) {
                    ToggleDatePicker(viewModel:
                        ToggleDatePickerViewModel(selection: $viewModel.lastMaintenanceDate))
                }
                LabeledContent(Copy.Appliance.purchasedDateLabel) {
                    ToggleDatePicker(viewModel:
                        ToggleDatePickerViewModel(selection: $viewModel.purchaseDate))
                }
                LabeledContent(Copy.Appliance.warrantyExpirationLabel) {
                    ToggleDatePicker(viewModel:
                        ToggleDatePickerViewModel(selection: $viewModel.warrantyExpirationDate))
                }

            }.environment(\.editMode, .constant(.active))
        }
    }

    var testButton: some ToolbarContent {
        ToolbarItem {
            Button("Test", systemImage: "testtube.2", action: viewModel.fetchTestData)
        }
    }

    var searchButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction, content: {
            Button(Copy.QuickCreate.searchModelLabel, systemImage: Copy.QuickCreate.searchModelSymbol, action: {
                Task {
                    await viewModel.fetchData()
                }
            }).disabled(viewModel.searchButtonDisabled)
        })
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: true))
    let app = Appliance(name: "Preview Appliance")
    container.mainContext.insert(app)
    return GalleryQuickCreateView(viewModel: GalleryQuickCreateViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
