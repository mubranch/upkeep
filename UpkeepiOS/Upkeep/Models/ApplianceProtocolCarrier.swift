//
//  ApplianceProtocolCarrier.swift
//  Upkeep
//
//  Created by Mustafa on 5/5/24.
//

import Foundation

struct AppliancePropertyCarrier: Identifiable {
    let id = UUID().uuidString
    var name: String = .none
    var category: Category?
    var brand: Brand?
    var modelNumber: String = .none
    var serialNumber: String = .none
    var purchaseDate: Date = .now
    var warrantyExpirationDate: Date = .now
    var lastMaintenaceDate: Date = .now
}
