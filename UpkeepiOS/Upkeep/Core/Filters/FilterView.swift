//
//  FilterSandbox.swift
//  Upkeep
//
//  Created by Mustafa on 5/1/24.
//

import SwiftData
import SwiftUI

struct FilterView: View {
    @StateObject var viewModel: FilterViewModel

    var body: some View {
        Menu {
            ForEach(viewModel.filteredBrands) { brand in
                Button(action: { viewModel.filter(for: brand) }) {
                    if viewModel.isActive(brand) {
                        Label(brand.name, systemImage: Copy.SimpleFilter.selectedBrandSymbol)
                    } else {
                        Text(brand.name)
                    }
                }
            }

            Divider()

            Button(Copy.SimpleFilter.clearFilterLabel, systemImage: Copy.SimpleFilter.clearFilterSymbol, action: viewModel.resetFilter)
        } label: {
            Image(systemName: Copy.SimpleFilter.sortButtonSymbol)
                .symbolVariant(.circle)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .padding(.leading)
        .disabled(viewModel.filteredBrands.isEmpty)
        .onChange(of: viewModel.filterManager.hasManuals, viewModel.updateFilter)
        .onChange(of: viewModel.filterManager.brands, viewModel.updateFilter)
        .onChange(of: viewModel.appliances, initial: true, viewModel.resetFilter)
    }
}
