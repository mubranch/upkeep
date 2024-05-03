//
//  Interstitial.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import SwiftUI

struct Interstitial: View {
    @State private var brand: ApplianceBrand = .generic
    @State private var modelNumber: String = ""
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
                    ToolbarItem(placement: .primaryAction, content: {
                        Button("Search", action: {
                            isFetching = true
                        })
                    })
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
        }
    }
}

#Preview {
    Interstitial(model: .constant(nil))
        .modelContainer(for: [Appliance.self, Manual.self])
}
