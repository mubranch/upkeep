//
//  Interstitial.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftData
import SwiftUI

struct AppliancePropertyCarrier: Identifiable {
    let id = UUID().uuidString
    var name: String = .none
    var category: Category?
    var brand: Brand?
    var modelNumber: String = .none
    var serialNumber: String = .none
    var purchaseDate: Date = .now
    var warrantyExpirationDate: Date = .now
    var lastMaintenaceDate: Date = .now
}

struct QuickCreate: View {
    @Binding var appliance: Appliance?

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) var editMode

    @State var carrier = AppliancePropertyCarrier()
    @State private var searchInProgress = false

    @Query(sort: \Brand.name) var brands: [Brand]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField(Copy.QuickCreate.modelNumberPrompt, text: $carrier.modelNumber)

                    LabeledContent(Copy.QuickCreate.brandPickerMenuLabel) {
                        Menu(carrier.brand?.name ?? Copy.QuickCreate.brandPickerPlaceholder) {
                            ForEach(brands, id: \.rawValue) { b in
                                Button(b.name) {
                                    carrier.brand = b
                                }.tag(b)
                            }
                        }
                    }
                }

                Section("Advanced") {
                    // Category toggle picker
                    LabeledContent(Copy.Appliance.typeLabel) {
                        CategoryTogglePicker(selection: $carrier.category)
                    }

                    LabeledContent(Copy.Appliance.serialNumberLabel) {
                        ToggleTextField(text: $carrier.serialNumber)
                    }

                    // Dates related to appliance maintenance and warranty
                    LabeledContent(Copy.Appliance.lastMaintenanceLabel) {
                        ToggleDatePicker(selection: $carrier.lastMaintenaceDate)
                    }
                    LabeledContent(Copy.Appliance.purchasedDateLabel) {
                        ToggleDatePicker(selection: $carrier.purchaseDate)
                    }
                    LabeledContent(Copy.Appliance.warrantyExpirationLabel) {
                        ToggleDatePicker(selection: $carrier.warrantyExpirationDate)
                    }
                }.environment(\.editMode, .constant(.active))
            }
            .navigationTitle("Quick Create")
            .toolbar {
                dismissButton
                testButton
                searchButton
            }
            .if(searchInProgress, transform: { _ in
                ProgressView()
                    .task {
                        await queryWebService()
                    }
            })
        }
    }

    var dismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading, content: {
            Button(Copy.QuickCreate.dismissActionLabel) {
                if appliance != nil {
                    modelContext.delete(appliance!)
                }
                appliance = nil
                dismiss()
            }
        })
    }

    var testButton: some ToolbarContent {
        ToolbarItem {
            Button("Test", systemImage: "testtube.2") {
                Task {
                    await queryWebServiceTest()
                }
            }
        }
    }

    var searchButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction, content: {
            Button(Copy.QuickCreate.searchModelLabel, systemImage: Copy.QuickCreate.searchModelSymbol, action: {
                searchInProgress = true
            }).disabled(carrier.modelNumber.isEmpty || carrier.brand == nil)
        })
    }

    @MainActor
    func queryWebService() async {
        guard let brand = carrier.brand else {
            return
        }

        guard let obj = await WebServiceController(modelContext: modelContext).fetchAppliance(brand: brand, modelNumber: carrier.modelNumber) else {
            appliance = nil
            return
        }

        searchInProgress = false

        obj.serialNumber = carrier.serialNumber
        obj.lastMaintenaceDate = carrier.lastMaintenaceDate
        obj.purchaseDate = carrier.purchaseDate
        obj.warrantyExpirationDate = carrier.warrantyExpirationDate

        if let category = carrier.category {
            obj.category = category
        }

        appliance = obj
        dismiss()
    }

    @MainActor
    func queryWebServiceTest() async {
        guard let obj = await WebServiceController(modelContext: modelContext).fetchApplianceTest() else {
            dismiss()
            return
        }
        appliance = obj
        dismiss()
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: true))
    let app = Appliance(name: "Hi")
    container.mainContext.insert(app)
    return QuickCreate(appliance: .constant(app))
        .modelContainer(container)
}
