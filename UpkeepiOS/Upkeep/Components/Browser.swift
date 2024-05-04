//
//  Browser.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

/// View for browsing web content.
struct Browser: View {
    @Environment(\.dismiss) var dismissAction
    @Environment(\.modelContext) var modelContext
    @State private var addedManual = false
    @State private var newManual: Manual?
    let pageUrl: URL?

    var body: some View {
        NavigationStack {
            VStack {
                // Web view displaying the content of the provided URL.
                WebView(downloadUrl: pageUrl,
                        modelContext: modelContext,
                        modelWasAdded: $addedManual,
                        closeFunction: { dismissAction() },
                        newManual: $newManual)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissButton()
                }
            }
            .sheet(item: $newManual, content: {
                ManualEditor(manual: $0)
            })
        }
    }
}
