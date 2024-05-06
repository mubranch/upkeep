//
//  BrandView.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

struct BrandsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    var body: some View {
        List {
            ForEach(viewModel.brands) { brand in
                Text(brand.name)
            }.onDelete(perform: viewModel.deleteBrand)
        }.navigationTitle("Brands")
    }
}
