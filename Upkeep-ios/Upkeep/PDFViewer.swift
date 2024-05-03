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
    @Environment(\.dismiss) var dismiss
    @Bindable var manual: Manual
    var body: some View {
        NavigationStack {
            PDFKitView(manual.file)
                .navigationTitle(manual.name)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        DismissButton()
                    }
                }
        }
    }
}
