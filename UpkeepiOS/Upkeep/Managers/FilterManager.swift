//
//  FilterController.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

struct FilterManager {
    var brands: Set<Brand> = []
    var hasManuals: Bool? = nil

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

    func reset() -> FilterManager {
        return FilterManager()
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
}

enum UpdateType {
    case reset
    case update
}
