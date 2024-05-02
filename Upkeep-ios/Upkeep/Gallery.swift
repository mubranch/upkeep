//
//  Gallery.swift
//  Upkeep
//
//  Created by Mustafa on 4/26/24.
//

import Foundation
import SwiftData
import SwiftUI

extension Design {
    enum Gallery {
        static let title = "Appliances"
        static let symbol = "powerplug.fill"
        static let addModelTitle = "Add Appliances"
        static let addModelSymbol = "plus"
    }
}

struct Gallery: View {
    @Environment(\.modelContext) private var modelContext
    @State private var filteredModel: [Appliance] = []
    @State private var selection: Appliance?
    @State private var newModel: Appliance?

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.filteredModel) { model in
                    NavigationLink(value: model, label: { Item(appliance: model) })
                }
                .onDelete(perform: self.deleteAppliance)
            }
            .listStyle(.plain)
            .navigationDestination(for: Appliance.self, destination: { model in
                Detail(model: model, type: .existing)
            })
            .navigationTitle(Design.Gallery.title)
            .toolbar {
                ToolbarItem {
                    SimpleFilter(target: self.$filteredModel)
                }

                ToolbarItem {
                    Button(Design.Gallery.addModelTitle, systemImage: Design.Gallery.addModelSymbol, action: self.generateAppliance)
                        .sheet(item: self.$newModel) { model in
                            Detail(model: model, type: .new)
                        }
                }
            }
        }
    }

    private func generateAppliance() {
        self.newModel = Appliance()
    }

    private func deleteAppliance(indexSet: IndexSet) {
        _ = indexSet.map { self.modelContext.delete(self.filteredModel[$0]) }
    }
}
