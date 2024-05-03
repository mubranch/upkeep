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
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    @Environment(\.modelContext) var modelContext
    @Bindable var model: Appliance
    @State private var urlWrapper: URLWrapper? = nil
    
    let type: ModelType
    
    enum ModelType {
        case new
        case existing
    }
    
    var dateFormat: Date.FormatStyle {
        .dateTime.day().month(.wide).year(.extended())
    }
    
    private var noSavedManuals: Bool { model.manuals.count == 0 }
    
    var body: some View {
        baseView
            .if(type == .new) { view in
                NavigationStack {
                    view
                        .environment(\.editMode, .constant(.active))
                        .toolbar {
                            newModelToolbar
                        }
                }
            }
            .if(type == .existing) { view in
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
                modelContext.delete(model)
                dismiss()
            }
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button("Save") {
                dismiss()
            }
        }
    }
    
    var editToolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction, content: {
            EditButton()
        })
    }
    
    var baseView: some View {
        List {
            Section {
                SymbolPickerButton(appliance: model)
            }
            
            LabeledContent(Design.Appliance.brandLabel) {
                BrandTogglePicker(selection: $model.brand)
            }
            LabeledContent(Design.Appliance.typeLabel) {
                CategoryTogglePicker(selection: $model.category)
            }.onChange(of: model.category, initial: true) {
                model.symbol = model.category?.symbol ?? .wrenchAndScrewdriverFill
            }
            
            LabeledContent(Design.Appliance.modelNumberLabel) {
                ToggleTextField(text: $model.modelNumber)
            }
            LabeledContent(Design.Appliance.serialNumberLabel) {
                ToggleTextField(text: $model.serialNumber)
            }
            
            Section {
                LabeledContent(Design.Appliance.lastMaintenanceLabel) {
                    ToggleDatePicker(selection: $model.lastMaintenaceDate)
                }
                LabeledContent(Design.Appliance.purchasedDateLabel) {
                    ToggleDatePicker(selection: $model.purchaseDate)
                }
                LabeledContent(Design.Appliance.warrantyExpirationLabel) {
                    ToggleDatePicker(selection: $model.warrantyExpirationDate)
                }
            }
            Section(Design.Appliance.manualsLabel) {
                ConditionalView(condition: !noSavedManuals, content: {
                    ForEach(model.manuals) {
                        ManualItem(manual: $0)
                    }
                })
                    
                Button(Design.Appliance.browserButtonLabel) {
                    if let brand = model.brand {
                        self.urlWrapper = URLWrapper(url: URL(string: "https://www.manuallib.com/s/0-0-\(brand.name)-0-0.html"))
                    } else {
                        self.urlWrapper = URLWrapper(url: URL(string: "https://www.manuallib.com/"))
                    }
                }
            }
        }
        .navigationTitle($model.name)
        .navigationBarTitleDisplayMode(.large)
        .sheet(item: $urlWrapper, content: { wrapper in
            Browser(url: wrapper.url)
        })
    }
    
    struct URLWrapper: Identifiable {
        let id = UUID().uuidString
        var url: URL?
    }
}

enum Design {
    enum Appliance {
        static let brandLabel = "Brand"
        static let typeLabel = "Type"
        static let modelNumberLabel = "Model Number"
        static let lastMaintenanceLabel = "Last Maintenance"
        static let purchasedDateLabel = "Purchase Date"
        static let warrantyExpirationLabel = "Warranty Expiration"
        static let serialNumberLabel = "Serial Number"
        static let manualsLabel = "Manuals"
        static let browserButtonLabel = "Find Manual"
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, configurations: .init(isStoredInMemoryOnly: true))
    let app = Appliance()
    container.mainContext.insert(app)
    return Detail(model: app, type: .new)
        .modelContainer(container)
}
