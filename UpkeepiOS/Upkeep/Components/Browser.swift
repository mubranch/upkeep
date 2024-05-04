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
    @State private var newManual: Manual?
    @Bindable var appliance: Appliance
    let baseURL: URL

    var body: some View {
        NavigationStack {
            VStack {
                // Web view displaying the content of the provided URL.
                WebView(newManual: $newManual,
                        baseURL: baseURL,
                        modelContext: modelContext)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismissAction()
                    }
                }
            }
            .sheet(item: $newManual, content: {
                ManualDetail(manual: $0, appliance: appliance)
            })
        }
    }
}
