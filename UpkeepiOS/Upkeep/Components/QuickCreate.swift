//
//  Interstitial.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftData
import SwiftUI

struct QuickCreate: View {
    @Binding var appliance: Appliance?

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) var editMode

    @State private var applianceBrand: Brand?
    @State private var modelNumber = String.none
    @State private var searchInProgress = false
    @State private var applianceCategory: Category?
    @State private var applianceSymbol: DefaultSymbols = .wrenchAndScrewdriverFill
    @State private var serialNumber = String.none
    @State private var lastMaintenanceDate = Date()
    @State private var purchaseDate = Date()
    @State private var warrantyExpirationDate = Date()
    @State private var isExpanded = false
    @State private var isEditing: EditMode = .active

    @Query(sort: \Brand.name) var brands: [Brand]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField(Copy.QuickCreate.modelNumberPrompt, text: $modelNumber)

                    LabeledContent(Copy.QuickCreate.brandPickerMenuLabel) {
                        Menu(applianceBrand?.name ?? Copy.QuickCreate.brandPickerPlaceholder) {
                            ForEach(brands, id: \.rawValue) { b in
                                Button(b.name) {
                                    applianceBrand = b
                                }.tag(b)
                            }
                        }
                    }
                }

                Button("Advanced") {
                    withAnimation {
                        isExpanded.toggle()
                        isEditing = isExpanded ? .active : .inactive
                    }
                }

                if isExpanded {
                    Section {
                        // Category toggle picker
                        LabeledContent(Copy.Appliance.typeLabel) {
                            CategoryTogglePicker(selection: $applianceCategory)
                        }

                        LabeledContent(Copy.Appliance.serialNumberLabel) {
                            ToggleTextField(text: $serialNumber)
                        }

                        // Dates related to appliance maintenance and warranty
                        LabeledContent(Copy.Appliance.lastMaintenanceLabel) {
                            ToggleDatePicker(selection: $lastMaintenanceDate)
                        }
                        LabeledContent(Copy.Appliance.purchasedDateLabel) {
                            ToggleDatePicker(selection: $purchaseDate)
                        }
                        LabeledContent(Copy.Appliance.warrantyExpirationLabel) {
                            ToggleDatePicker(selection: $warrantyExpirationDate)
                        }
                    }.environment(\.editMode, $isEditing)
                }
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
            }).disabled(modelNumber.isEmpty || applianceBrand == nil)
        })
    }

    @MainActor
    func queryWebService() async {
        guard let brand = appliance?.brand else {
            return
        }

        guard let obj = await WebServiceController(modelContext: modelContext).fetchAppliance(brand: brand, modelNumber: modelNumber) else {
            appliance = nil
            return
        }

        searchInProgress = false
        appliance = obj
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
