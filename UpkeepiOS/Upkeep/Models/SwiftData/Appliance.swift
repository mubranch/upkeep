//
//  Appliance.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftData

@Model
final class Appliance: Identifiable {
    var id = UUID().uuidString
    var name: String
    var category: Category?
    var brand: Brand?
    var modelNumber: String
    var serialNumber: String
    var purchaseDate: Date
    var warrantyExpirationDate: Date
    var lastMaintenaceDate: Date
    var symbol: DefaultSymbols
    var manuals: [Manual]

    init(name: String? = nil,
         category: Category? = nil,
         brand: Brand? = nil,
         modelNumber: String? = nil,
         serialNumber: String? = nil,
         purchaseDate: Date = Date(),
         warrantyExpirationDate: Date = Date(),
                                          lastMaintenanceDate: Date = Date(),
         symbol: DefaultSymbols? = nil,
         manuals: [Manual] = [Manual]())
    {
        self.name = name != nil ? name! : "New Appliance"
        self.category = category
        self.brand = brand
        self.modelNumber = modelNumber ?? ""
        self.serialNumber = serialNumber ?? ""
        self.purchaseDate = purchaseDate
        self.warrantyExpirationDate = warrantyExpirationDate
        self.lastMaintenaceDate =                                  lastMaintenanceDate
        self.symbol = symbol != nil ? symbol! : (category != nil ? category!.symbol : .wrenchAndScrewdriverFill)
        self.manuals = manuals
    }
}
