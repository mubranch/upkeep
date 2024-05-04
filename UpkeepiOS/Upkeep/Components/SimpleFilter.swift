//
//  FilterSandbox.swift
//  Upkeep
//
//  Created by Mustafa on 5/1/24.
//

import SwiftData
import SwiftUI

struct SimpleFilter: View {
    @Binding var filteredAppliances: [Appliance]

    @State var filterController = FilterController()

    @Query var appliances: [Appliance]
    @Query var brands: [Brand]

    var body: some View {
        Menu {
            ForEach(brandsForModelsInContext) { brand in
                let isActive = filterController.brands.contains(brand)

                Button(action: { updateFilter(brand) }) {
                    if isActive {
                        Label(brand.name, systemImage: Copy.SimpleFilter.selectedBrandSymbol)
                    } else {
                        Text(brand.name)
                    }
                }
            }

            Divider()

            Button(Copy.SimpleFilter.clearFilterLabel, systemImage: Copy.SimpleFilter.clearFilterSymbol) {
                updateFilter(.reset)
            }
        } label: {
            Image(systemName: Copy.SimpleFilter.sortButtonSymbol)
                .symbolVariant(.circle)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .padding(.leading)
        .disabled(brandsForModelsInContext.isEmpty)
        .onChange(of: filterController.hasManuals) {
            updateFilter(.update)
        }
        .onChange(of: appliances, initial: true) {
            updateFilter(.reset)
        }
        .onChange(of: filterController.brands) {
            updateFilter(.update)
        }
    }

    var brandsForModelsInContext: [Brand] {
        appliances.compactMap {
            if $0.brand != nil {
                return $0.brand!
            } else {
                return nil
            }
        }
    }

    private func updateFilter(_ type: UpdateType) {
        withAnimation {
            switch type {
            case .reset:
                filteredAppliances = appliances
                filterController = filterController.reset()
            case .update:
                filteredAppliances = filterController.filter(appliances: appliances)
            }
        }
    }

    private func updateFilter(_ brand: Brand) {
        if filterController.brands.contains(brand) {
            filterController.brands.remove(brand)
        } else {
            filterController.brands.insert(brand)
        }
    }
}
