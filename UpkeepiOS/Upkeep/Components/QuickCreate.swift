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

    @State private var applianceBrand: Brand?
    @State private var modelNumber = String.none
    @State private var searchInProgress = false

    @Query(sort: \Brand.name) var brands: [Brand]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    LabeledContent(Copy.QuickCreate.brandPickerMenuLabel) {
                        Menu(applianceBrand?.name ?? Copy.QuickCreate.brandPickerPlaceholder) {
                            ForEach(brands, id: \.rawValue) { b in
                                Button(b.name) {
                                    applianceBrand = b
                                }.tag(b)
                            }
                        }
                    }

                    TextField(Copy.QuickCreate.modelNumberPrompt, text: $modelNumber)
                }
            }
            .toolbar {
                dismissButton
                manualButton
                testButton
                searchButton
            }
            .if(searchInProgress, transform: { _ in
                ProgressView()
                    .task {
                        await queryWebService()
                    }
            })
        }.presentationDetents([.fraction(0.35)])
    }

    var dismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading, content: {
            Button(Copy.QuickCreate.dismissActionLabel) {
                if appliance != nil {
                    modelContext.delete(appliance!)
                }
                appliance = nil
                dismiss()
            }.tint(.red)
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

    var manualButton: some ToolbarContent {
        ToolbarItem {
            Button(Copy.QuickCreate.manualModelLabel) {
                let appliance = Appliance()
                modelContext.insert(appliance)
                self.appliance = appliance
                dismiss()
            }
        }
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
    QuickCreate(appliance: .constant(nil))
        .modelContainer(for: [Appliance.self, Manual.self])
}
