//
//  FilterController.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

class FilterManager {
    var brands: Set<Brand> = []
    var hasManuals: Bool?

    var noBrandFilter: Bool { brands.isEmpty }
    var noManualFilter: Bool { hasManuals == nil }

    var isActive: Bool {
        !noBrandFilter || !noManualFilter
    }

    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "FilterManager")

    func filter(appliances: [Appliance]) -> [Appliance] {
        logger.logInfo("Starting filter operation")
        let filteredAppliances = appliances.filter { appliance in
            (noBrandFilter || checkForBrand(appliance)) &&
                (noManualFilter || checkForManuals(appliance))
        }
        logger.logInfo("Filter operation completed. \(filteredAppliances.count) appliances passed the filter.")
        return filteredAppliances
    }

    func reset() -> FilterManager {
        logger.logInfo("Resetting filter settings to default.")
        return FilterManager()
    }

    private func checkForManuals(_ appliance: Appliance) -> Bool {
        guard let hasManuals = hasManuals else {
            return true
        }
        let result = !appliance.manuals.isEmpty == hasManuals
        logger.logInfo("Manuals check: \(result) for appliance ID \(appliance.id)")
        return result
    }

    private func checkForBrand(_ appliance: Appliance) -> Bool {
        guard let brand = appliance.brand else {
            logger.logInfo("Brand check failed: no brand for appliance ID \(appliance.id)")
            return false
        }
        let result = brands.contains(brand)
        logger.logInfo("Brand check: \(result) for brand \(brand.name) in appliance ID \(appliance.id)")
        return result
    }
}

enum UpdateType {
    case reset
    case update
}
