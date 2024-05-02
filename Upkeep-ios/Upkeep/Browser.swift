//
//  Browser.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

struct Browser: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var didAddManual = false
    @State private var newManual: Manual?
    let url: URL?

    var body: some View {
        NavigationStack {
            VStack {
                WebView(downloadUrl: url,
                        modelContext: modelContext,
                        modelWasAdded: $didAddManual,
                        closeFunction: { dismiss() },
                        newManual: $newManual)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        self.dismiss()
                    }
                }
            }
            .sheet(item: $newManual, content: {
                ManualEditor(manual: $0)
            })
        }
    }
}
