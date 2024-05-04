//
//  Interstitial.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftData
import SwiftUI

struct Interstitial: View {
    @Binding var appliance: Appliance?

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var newBrand: Brand?
    @State private var modelNumber = String.none
    @State private var searchInProgress = false

    @Query(sort: \Brand.name) var brands: [Brand]

    var body: some View {
        NavigationStack {
            List {
                LabeledContent(Copy.Interstitial.brandPickerMenuLabel) {
                    Menu(newBrand?.name ?? Copy.Interstitial.brandPickerPlaceholder) {
                        ForEach(brands, id: \.rawValue) { b in
                            Button(b.name) {
                                newBrand = b
                            }.tag(b)
                        }
                    }
                }

                TextField(Copy.Interstitial.modelNumberPrompt, text: $modelNumber)
            }
            .toolbar {
                dismissButton
                saveButton
            }
            .if(searchInProgress, transform: { _ in
                ProgressView()
                    .task { @MainActor in
                        await queryWebService()
                    }
                    .onChange(of: appliance) {
                        dismiss()
                    }
            })
        }.presentationDetents([.fraction(0.35)])
    }

    var dismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading, content: {
            DismissButton()
        })
    }

    var saveButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction, content: {
            Button(Copy.Interstitial.saveModelLabel, action: {
                if modelNumber.isEmpty {
                    appliance = .init()
                } else {
                    searchInProgress = true
                }
            })
        })
    }

    private func queryWebService() async {
        let webService = WebController(modelContext: modelContext)

        appliance = await Task {
            do {
                if let brand = newBrand {
                    let obj = try await webService.fetchAppliance(brand: brand, modelNumber: modelNumber)
                    searchInProgress = false
                    return obj
                } else {
                    // TODO: Add Error Handling
                    return nil
                }
            } catch {
                // TODO: Add Error Handling
                return nil
            }
        }.value

        if appliance != nil {
            dismiss()
        }
    }
}

#Preview {
    Interstitial(appliance: .constant(nil))
        .modelContainer(for: [Appliance.self, Manual.self])
}
