//
//  Gallery.swift
//  Upkeep
//
//  Created by Mustafa on 4/26/24.
//

import Foundation
import SwiftData
import SwiftUI

struct Gallery: View {
    @Environment(\.modelContext) private var modelContext
    @State private var filteredAppliances: [Appliance] = []
    @State private var selectedAppliance: Appliance?
    @State private var newAppliance: Appliance?
    @State private var isAddingNewAppliance = false

    var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle(Copy.Gallery.pageTitle)
                .toolbar {
                    filterButton
                    addButton
                }
        }
    }

    private var mainContent: some View {
        List {
            ForEach(filteredAppliances) { appliance in
                NavigationLink {
                    Detail(appliance: appliance, modelType: .existing)
                } label: {
                    Item(appliance: appliance)
                }
            }
            .onDelete(perform: deleteAppliance)
        }
        .listStyle(.plain)
    }

    private var filterButton: some ToolbarContent {
        ToolbarItem {
            SimpleFilter(filteredAppliances: $filteredAppliances)
        }
    }

    private var addButton: some ToolbarContent {
        ToolbarItem {
            Button(action: addNewAppliance) {
                // Button to initiate adding a new appliance
                Label(Copy.Gallery.primaryActionLabel, systemImage: Copy.Gallery.primaryActionSymbol)
            }
            .sheet(isPresented: $isAddingNewAppliance) {
                QuickCreate(appliance: $newAppliance)
            }
            .sheet(item: $newAppliance, content: { appliance in
                Detail(appliance: appliance, modelType: .new)
            })
        }
    }

    private func addNewAppliance() {
        isAddingNewAppliance.toggle()
    }

    private func deleteAppliance(indexSet: IndexSet) {
        _ = indexSet.map { modelContext.delete(filteredAppliances[$0]) }
    }
}
