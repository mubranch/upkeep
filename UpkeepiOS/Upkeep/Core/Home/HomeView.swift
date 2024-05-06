//
//  Home.swift
//  Upkeep
//
//  Created by Mustafa on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        TabView {
            GalleryView(viewModel:
                GalleryViewModel(filterTarget: $viewModel.appliances, modelContext: viewModel.modelContext))
                .tabItem {
                    Label("Appliances", systemImage: "refrigerator")
                        .environment(\.symbolVariants, .none)
                }
            SettingsView(viewModel:
                SettingsViewModel(modelContext: viewModel.modelContext))
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Appliance.self, Manual.self, Brand.self, Category.self, configurations: .init(isStoredInMemoryOnly: false))

    return HomeView(viewModel: HomeViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
