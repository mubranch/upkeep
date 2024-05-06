//
//  CategoryView.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

struct CategoryView: View {
    @ObservedObject var viewModel: SettingsViewModel
    var body: some View {
        List {
            ForEach(viewModel.categories) { category in
                Text(category.title)
            }.onDelete(perform: viewModel.deleteCategory)
        }.navigationTitle("Categories")
    }
}
