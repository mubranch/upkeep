//
//  ApplianceDetail.swift
//  Upkeep
//
//  Created by Mustafa on 4/26/24.
//

import Foundation
import SwiftData
import SwiftUI

struct ApplianceDetailView: View {
    @Environment(\.editMode) var editMode
    
    @StateObject var viewModel: ApplianceDetailViewModel
    @ObservedObject var togglePickerViewModel: TogglePickerViewModel
    
    var dateFormat: Date.FormatStyle {
        .dateTime.day().month(.wide).year(.extended())
    }
    
    var body: some View {
        baseContent
            .onChange(of: viewModel.shouldDismiss, viewModel.dismiss)
            .if(viewModel.isNewModel) { view in
                NavigationStack {
                    view
                        .navigationTitle($viewModel.appliance.name)
                        .environment(\.editMode, .constant(.active))
                        .toolbar {
                            newModelToolbar
                        }
                }
            }
            .if(!viewModel.isNewModel) { view in
                view
                    .toolbar {
                        editToolbar
                    }
            }
    }
    
    @ToolbarContentBuilder
    var newModelToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel", action: viewModel.deleteModel)
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button("Save", action: viewModel.dismiss)
        }
    }
    
    var editToolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            EditButton()
        }
    }
    
    var baseContent: some View {
        List {
            // Appliance symbol picker
            Section {
                SymbolPickerButton(viewModel:
                    SymbolPickerButtonViewModel(appliance: $viewModel.appliance))
                    .disabled(editMode?.wrappedValue.isEditing == false)
            }
            
            // Brand toggle picker
            LabeledContent(Copy.Appliance.brandLabel) {
                BrandTogglePicker(viewModel: togglePickerViewModel)
            }
            
            // Category toggle picker
            LabeledContent(Copy.Appliance.typeLabel) {
                CategoryTogglePicker(viewModel: togglePickerViewModel)
            }.onChange(of: viewModel.appliance.category, initial: true) {
                viewModel.appliance.symbol = viewModel.appliance.category?.symbol ?? .wrenchAndScrewdriverFill
            }
            
            // Model number and serial number fields
            LabeledContent(Copy.Appliance.modelNumberLabel) {
                ToggleTextField(viewModel:
                    ToggleTextFieldViewModel(text: $viewModel.appliance.modelNumber))
            }
            
            LabeledContent(Copy.Appliance.serialNumberLabel) {
                ToggleTextField(viewModel:
                    ToggleTextFieldViewModel(text: $viewModel.appliance.serialNumber))
            }
            
            // Dates related to appliance maintenance and warranty
            Section {
                LabeledContent(Copy.Appliance.lastMaintenanceLabel) {
                    ToggleDatePicker(viewModel:
                        ToggleDatePickerViewModel(selection: $viewModel.appliance.lastMaintenaceDate))
                }
                LabeledContent(Copy.Appliance.purchasedDateLabel) {
                    ToggleDatePicker(viewModel:
                        ToggleDatePickerViewModel(selection: $viewModel.appliance.purchaseDate))
                }
                LabeledContent(Copy.Appliance.warrantyExpirationLabel) {
                    ToggleDatePicker(viewModel:
                        ToggleDatePickerViewModel(selection: $viewModel.appliance.warrantyExpirationDate))
                }
            }
            
            // Manuals section
            Section(Copy.Appliance.manualsLabel) {
                ForEach($viewModel.appliance.manuals) { $manual in
                    ManualItem(viewModel: ManualItemViewModel(manual: manual,
                                                              appliance: viewModel.appliance,
                                                              modelContext: viewModel.modelContext))
                }
            }
            
            // Button for browsing and saving manuals online
            Section {
                Button(Copy.Appliance.browserButtonLabel, systemImage: "magnifyingglass", action: viewModel.buildUrlWrapper)
            }
        }
        .navigationTitle($viewModel.appliance.name)
        .sheet(item: $viewModel.urlWrapper) { wrapper in
            WebView(viewModel: WebViewModel(appliance: viewModel.appliance,
                                            modelContext: viewModel.modelContext,
                                            defaultUrl: wrapper.url))
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, configurations: .init(isStoredInMemoryOnly: true))
    @Bindable var app = Appliance()
    container.mainContext.insert(app)
    return ApplianceDetailView(viewModel: ApplianceDetailViewModel(appliance: app, modelContext: container.mainContext), togglePickerViewModel: TogglePickerViewModel(selectedBrand: $app.brand, selectedCategory: $app.category, modelContext: container.mainContext))
        .modelContainer(container)
}
