//
//  PDFViewer.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

struct PDFViewer: View {
    @StateObject var viewModel: PDFViewerViewModel

    var body: some View {
        NavigationStack {
            PDFKitView(viewModel.manual.file)
                .navigationTitle(viewModel.manual.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Close", action: viewModel.dismiss)
                }
        }
    }
}
