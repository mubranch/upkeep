//
//  ManualItem.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import SwiftData
import SwiftUI

struct ManualItem: View {
    @StateObject var viewModel: ManualItemViewModel

    var body: some View {
        Button(viewModel.manual.name, action: viewModel.openManual)
            .lineLimit(1)
            .sheet(item: $viewModel.isEditing, content: { manual in
                ManualDetail(viewModel: ManualDetailViewModel(appliance: viewModel.appliance,
                                                              manual: manual,
                                                              modelContext: viewModel.modelContext))
            })
            .fullScreenCover(item: $viewModel.isOpen, content: {
                PDFViewer(viewModel: PDFViewerViewModel(manual: $0))
            })
            .swipeActions(edge: .trailing) {
                Button("Delete", systemImage: "trash", action: viewModel.deleteManual)
                    .tint(.red)
            }
            .contextMenu {
                Button("Edit", action: viewModel.editManual)
                Button("Open", action: viewModel.openManual)
            }
    }
}
