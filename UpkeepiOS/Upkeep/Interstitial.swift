//
//  Interstitial.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftUI

struct Interstitial: View {
    @Environment(\.dismiss) var dismiss
    @State private var brand: ApplianceBrand = .generic
    @State private var modelNumber: String = "KRFF577KPS"
    @State private var isFetching = false
    @Binding var model: Appliance?

    var body: some View {
        NavigationStack {
            if !isFetching {
                List {
                    Picker("Brand", selection: $brand) {
                        ForEach(ApplianceBrand.allCases, id: \.rawValue) {
                            Text($0.rawValue)
                                .tag($0)
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
                    .task {
                        model = await Task {
                            do {
                                let obj = try await WebService.fetchApplianceTest()
                                isFetching = false
                                return obj
                            } catch {
                                print(error)
                                isFetching = false
                                return nil
                            }
                        }.value
                    }
            }
        }.presentationDetents([.fraction(0.35)])
    }
}

#Preview {
    Interstitial(model: .constant(nil))
        .modelContainer(for: [Appliance.self, Manual.self])
}
