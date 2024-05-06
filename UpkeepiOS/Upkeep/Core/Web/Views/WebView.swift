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
struct WebView: View {
    @StateObject var viewModel: WebViewModel

    var body: some View {
        NavigationStack {
            // Web view displaying the content of the provided URL.
            WebKitView(viewModel: WebKitViewModel(newManual: $viewModel.newManual,
                                                  activeUrl: viewModel.defaultUrl,
                                                  modelContext: viewModel.modelContext))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close", action: viewModel.dismiss)
                    }
                }
                .sheet(item: $viewModel.newManual, content: { manual in
                    ManualDetail(viewModel: ManualDetailViewModel(appliance: viewModel.appliance,
                                                                  manual: manual,
                                                                  modelContext: viewModel.modelContext))
                })
        }
    }
}
