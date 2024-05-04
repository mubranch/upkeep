//
//  ApplianceDetail.swift
//  Upkeep
//
//  Created by Mustafa on 4/26/24.
//

import Foundation
import SwiftData
import SwiftUI

struct Detail: View {
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
                        ManualItem(manual: manual)
                    }
                }
                
                // Button for browsing and saving manuals online
                Button(Copy.Appliance.browserButtonLabel) {
                    let urlString: String
                    if let brand = appliance.brand {
                        urlString = "https://www.manuallib.com/s/0-0-\(brand.name)-0-0.html"
                    } else {
                        urlString = "https://www.manuallib.com/"
                    }
                    self.urlWrapper = URLWrapper(url: URL(string: urlString))
                }
            }
        }
        .navigationTitle($appliance.name)
        .navigationBarTitleDisplayMode(.large)
        .sheet(item: $urlWrapper) { wrapper in
            Browser(pageUrl: wrapper.url)
        }
    }
    
    /// Adds identifable conformance to a URL allowing use of the .sheet(item: ...) view modifier
    struct URLWrapper: Identifiable {
        let id = UUID()
        var url: URL?
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, configurations: .init(isStoredInMemoryOnly: true))
    let app = Appliance()
    container.mainContext.insert(app)
    return Detail(appliance: app, modelType: .new)
        .modelContainer(container)
}
