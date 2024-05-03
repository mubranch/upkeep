//
//  BrandFilter.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI

class FilterController: ObservableObject {
    @Published var brands: Set<Brand> = []

    @Published var hasManuals: Bool? = nil

    var noBrandFilter: Bool { brands.isEmpty }
    var noManualFilter: Bool { hasManuals == nil }

    var isActive: Bool {
        !noBrandFilter || !noManualFilter
    }

    func filter(appliances: [Appliance]) -> [Appliance] {
        return appliances.filter {
            switch noBrandFilter && noManualFilter {
            case true:
                if !noBrandFilter, !noManualFilter {
                    return checkForManualsAndBrand($0)
                } else {
                    return true
                }
            case false:
                if !noBrandFilter, noManualFilter {
                    return checkForBrand($0)
                } else if noBrandFilter, !noManualFilter {
                    return checkForManuals($0)
                } else {
                    return false
                }
            }
        }
    }

    func reset(appliances: [Appliance]) -> [Appliance] {
        brands.removeAll()
        hasManuals = nil
        return appliances
    }

    private func checkForManualsAndBrand(_ appliance: Appliance) -> Bool {
        if checkForManuals(appliance) {
            return checkForBrand(appliance)
        } else {
            return false
        }
    }

    private func checkForManuals(_ appliance: Appliance) -> Bool {
        if (appliance.manuals.count != 0) == hasManuals {
            return true
        } else {
            return false
        }
    }

    private func checkForBrand(_ appliance: Appliance) -> Bool {
        guard let brand = appliance.brand else {
            return false
        }

        if brands.contains(brand) {
            return true
        } else {
            return false
        }
    }

    enum UpdateType {
        case reset
        case update
    }
}

extension Sequence<Appliance> {
    func extractBrands() -> [Brand] {
        return Array(Set(compactMap { $0.brand })).sorted(by: {
            $0.rawValue > $1.rawValue
        })
    }
}

struct BrandFilter: View {
    @Query var appliances: [Appliance]
    @StateObject private var filter = FilterController()
    @Binding var target: [Appliance]

    var brands: [Brand] {
        appliances.extractBrands()
    }

    var brandButton: some View {
        HStack {
            ForEach(brands, id: \.rawValue) { brand in
                let isSelected = filter.brands.contains(where: {
                    $0 == brand
                })

                Button(brand.name) {
                    withAnimation {
                        if !isSelected {
                            filter.brands.insert(brand)
                        } else {
                            filter.brands.remove(brand)
                        }
                    }
                }
                .if(isSelected, transform: {
                    $0
                        .buttonStyle(.borderedProminent)
                        .tint(Color.accentColor)
                })
                .if(!isSelected, transform: {
                    $0
                        .buttonStyle(.bordered)
                })
                .buttonBorderShape(.capsule)
            }
        }
    }

    @ViewBuilder
    var manualButton: some View {
        let pickerLabel = filter.hasManuals == nil ? "Filter" : (filter.hasManuals?.description ?? "ERROR")

        Menu(pickerLabel) {
            Button("Has Manuals") { filter.hasManuals = true }
            Button("Has No Manuals") { filter.hasManuals = false }
            Button("Clear") { filter.hasManuals = nil }
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
//        .if(filter.hasManuals != nil) {
//            $0
//                .tint(Color.accentColor)
//                .buttonStyle(.borderedProminent)
//        }
        .padding(.leading)
    }

    var resetButton: some View {
        Button("Clear", systemImage: "arrow.circlepath") {
            updateFilter(.reset)
        }
        .buttonStyle(.bordered)
        .labelStyle(.iconOnly)
        .buttonBorderShape(.circle)
        .tint(.red)
        .bold()
    }

    var body: some View {
        VStack {
            ScrollViewReader { reader in
                VStack(alignment: .leading) {
                    ScrollView(.horizontal) {
                        HStack {
                            if filter.isActive {
                                resetButton
                            }
                            brandButton
                        }.id(0)
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, 15, for: .scrollContent)
                    .onChange(of: filter.brands) {
                        withAnimation {
                            reader.scrollTo(0, anchor: .leading)
                        }
                    }

                    manualButton
                }
                .font(.subheadline)
            }
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
}
