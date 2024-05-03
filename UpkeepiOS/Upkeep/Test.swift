//
//  TestView.swift
//  Upkeep
//
//  Created by Mustafa on 5/1/24.
//

import Foundation
import SwiftData
import SwiftUI

struct Test: View {
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List {
                Button("Reset", systemImage: "arrow.circlepath") {
                    modelContext.container.deleteAllData()
                }
                Button("Populate", systemImage: "swiftdata") {
                    for num in 0 ... Int.random(in: 0 ... 20) {
                        let appliance = Appliance()
                        modelContext.insert(appliance)
                        if num % 2 == 0 {
                            if let url = URL(string: "https://data2.manualslib.com/pdf7/330/32906/3290542-kitchenaid/krmf706ess.pdf?601e6ae19ee52c55d34e84d5d4616ea8"), let file = try? Data(contentsOf: url) {
                                let manual = Manual(name: "\(appliance.name) \(appliance.id) Manual", type: "Manual", file: file)
                                modelContext.insert(manual)
                                manual.appliance = appliance
                            }
                        }
                    }
                }
            }
            .navigationTitle("Preview Controller")
        }
    }
}
