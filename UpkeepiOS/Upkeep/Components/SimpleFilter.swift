//
//  FilterSandbox.swift
//  Upkeep
//
//  Created by Mustafa on 5/1/24.
//

import SwiftData
import SwiftUI

struct SimpleFilter: View {
    @Query var appliances: [Appliance]
    @StateObject var filter = FilterController()
    @Binding var target: [Appliance]
    @Query var brands: [Brand]

    var body: some View {
        Menu {
            ForEach(brands) { brand in
                let isActive = filter.brands.contains(brand)

                Button(action: { updateFilter(brand) }) {
                    if isActive {
                        Label(brand.name, systemImage: "checkmark")
                    } else {
                        Text(brand.name)
                    }
                }
            }

            Divider()

            Button("Clear", systemImage: "xmark") {
                updateFilter(.reset)
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .symbolVariant(.circle)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .padding(.leading)
        .onChange(of: filter.hasManuals) {
            updateFilter(.update)
        }
        .onChange(of: appliances, initial: true) {
            updateFilter(.reset)
        }
        .onChange(of: filter.brands) {
            updateFilter(.update)
        }
    }

    private func updateFilter(_ type: FilterController.UpdateType) {
        withAnimation {
            switch type {
            case .reset:
                target = filter.reset(appliances: appliances)
            case .update:
                target = filter.filter(appliances: appliances)
            }
        }
    }

    private func updateFilter(_ brand: Brand) {
        if filter.brands.contains(brand) {
            filter.brands.remove(brand)
        } else {
            filter.brands.insert(brand)
        }
    }
}
