//
//  ApplianceDetail.swift
//  Upkeep
//
//  Created by Mustafa on 4/26/24.
//

import Foundation
import SwiftData
import SwiftUI

struct ApplianceDetail: View {
    @Environment(\.dismiss) var dismissAction
    @Environment(\.editMode) var editMode
    @Environment(\.modelContext) var modelContext
    
    @Bindable var appliance: Appliance
    
    @State private var urlWrapper: URLWrapper? = nil
    
    let modelType: ModelType
    
    /// Enum for caller to set Detail view type
    enum ModelType {
        case new
        case existing
    }
    
    var dateFormat: Date.FormatStyle {
        .dateTime.day().month(.wide).year(.extended())
    }
    
    private var hasManualsSaved: Bool {
        !appliance.manuals.isEmpty
    }
    
    var body: some View {
        baseContent
            .if(modelType == .new) { view in
                NavigationStack {
                    view
                        .navigationTitle($appliance.name)
                        .environment(\.editMode, .constant(.active))
                        .toolbar {
                            newModelToolbar
                        }
                }
            }
            .if(modelType == .existing) { view in
                view
                    .toolbar {
                        editToolbar
                    }
            }
    }
    
    @ToolbarContentBuilder
    var newModelToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Dismiss") {
                modelContext.delete(appliance)
                dismissAction()
            }
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button("Save") {
                dismissAction()
            }
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
                SymbolPickerButton(appliance: appliance)
                    .disabled(editMode?.wrappedValue.isEditing == false)
            }
            
            // Brand toggle picker
            LabeledContent(Copy.Appliance.brandLabel) {
                BrandTogglePicker(selection: $appliance.brand)
            }
            
            // Category toggle picker
            LabeledContent(Copy.Appliance.typeLabel) {
                CategoryTogglePicker(selection: $appliance.category)
            }.onChange(of: appliance.category, initial: true) {
                appliance.symbol = appliance.category?.symbol ?? .wrenchAndScrewdriverFill
            }
            
            // Model number and serial number fields
            LabeledContent(Copy.Appliance.modelNumberLabel) {
                ToggleTextField(text: $appliance.modelNumber)
            }
            LabeledContent(Copy.Appliance.serialNumberLabel) {
                ToggleTextField(text: $appliance.serialNumber)
            }
            
            // Dates related to appliance maintenance and warranty
            Section {
                LabeledContent(Copy.Appliance.lastMaintenanceLabel) {
                    ToggleDatePicker(selection: $appliance.lastMaintenaceDate)
                }
                LabeledContent(Copy.Appliance.purchasedDateLabel) {
                    ToggleDatePicker(selection: $appliance.purchaseDate)
                }
                LabeledContent(Copy.Appliance.warrantyExpirationLabel) {
                    ToggleDatePicker(selection: $appliance.warrantyExpirationDate)
                }
            }
            
            // Manuals section
            Section(Copy.Appliance.manualsLabel) {
                ConditionalView(condition: hasManualsSaved) {
                    ForEach(appliance.manuals) { manual in
                        ManualItem(manual: manual, appliance: appliance)
                    }
                }
            }
            
            // Button for browsing and saving manuals online
            Section {
                Button(Copy.Appliance.browserButtonLabel, systemImage: "magnifyingglass") {
                    let urlString: String
                    
                    if !appliance.modelNumber.isEmpty {
                        urlString = "https://www.manualslib.com/\(appliance.modelNumber.first!.lowercased())/\(appliance.modelNumber.lowercased()).html"
                    } else {
                        urlString = "https://www.manualslib.com/"
                    }
                    
                    if let url = URL(string: urlString) {
                        self.urlWrapper = URLWrapper(url: url)
                    }
                }
            }
        }
        .navigationTitle($appliance.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $urlWrapper) { wrapper in
            // TODO: add error handling here
            Browser(appliance: appliance, baseURL: wrapper.url)
        }
    }
    
    /// Adds identifable conformance to a URL allowing use of the .sheet(item: ...) view modifier
    struct URLWrapper: Identifiable {
        let id = UUID()
        var url: URL
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, configurations: .init(isStoredInMemoryOnly: true))
    let app = Appliance()
    container.mainContext.insert(app)
    return ApplianceDetail(appliance: app, modelType: .new)
        .modelContainer(container)
}