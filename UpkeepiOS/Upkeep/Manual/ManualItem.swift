//
//  ManualItem.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import SwiftData
import SwiftUI

struct ManualItem: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var manual: Manual
    @Bindable var appliance: Appliance
    @State var selectedManual: Manual?
    @State var editingManual: Manual?

    var body: some View {
        Button(manual.name) {
            selectedManual = manual
        }
        .lineLimit(1)
        .sheet(item: $editingManual, content: {
            ManualDetail(manual: $0, appliance: appliance)
        })
        .fullScreenCover(item: $selectedManual, content: {
            PDFViewer(manual: $0)
        })
        .swipeActions(edge: .trailing) {
            Button("Delete", systemImage: "trash") {
                withAnimation {
                    modelContext.delete(manual)
                }
            }.tint(.red)
        }
        .contextMenu {
            Button("Edit") {
                editingManual = manual
            }
            Button("Open") {
                selectedManual = manual
            }
        }
    }
}
