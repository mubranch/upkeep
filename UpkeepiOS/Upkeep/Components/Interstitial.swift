//
//  Interstitial.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftData
import SwiftUI

struct Interstitial: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Brand.name) var brands: [Brand]
    @Environment(\.dismiss) var dismiss
    @State private var brand: Brand?
    @State private var modelNumber: String = "KRFF577KPS"
    @State private var isFetching = false
    @Binding var model: Appliance?

    var body: some View {
        NavigationStack {
            ZStack {
                if !isFetching {
                    List {
                        LabeledContent("Brand") {
                            Menu(brand?.name ?? brands.first?.name ?? "ERROR") {
                                ForEach(brands, id: \.rawValue) { b in
                                    Button(b.name) {
                                        brand = b
                                    }.tag(b)
                                }
                            }
                        }

                        TextField("Model Number", text: $modelNumber)

                    }.toolbar {
                        ToolbarItem(placement: .topBarLeading, content: {
                            DismissButton()
                        })

                        ToolbarItem(placement: .primaryAction, content: {
                            Button("Search", action: {
                                if modelNumber.isEmpty {
                                    model = .init()
                                } else {
                                    isFetching = true
                                }
                            })
                        })
                    }
                    .onChange(of: model) {
                        dismiss()
                    }
                } else {
                    ProgressView()
                        .task { @MainActor in
                            let webService = WebService(modelContext: modelContext)
                            model = await Task {
                                do {
                                    if let brand = brand {
                                        let obj = try await webService.fetchAppliance(brand: brand, modelNumber: modelNumber)
                                        isFetching = false
                                        return obj
                                    } else {
                                        return nil
                                    }
                                } catch {
                                    print(error)
                                    isFetching = false
                                    return nil
                                }
                            }.value
                        }
                }
            }
        }.presentationDetents([.fraction(0.35)])
    }
}

#Preview {
    Interstitial(model: .constant(nil))
        .modelContainer(for: [Appliance.self, Manual.self])
}
