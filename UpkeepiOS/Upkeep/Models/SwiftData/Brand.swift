//
//  Brand.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftData

protocol BrandProtocol: Identifiable, Codable, Hashable {
    var name: String { get }
}

@Model
final class Brand: BrandProtocol {
    @Attribute(.unique) var name: String
    private var appliances: [Appliance] = []

    init(name: String) {
        self.name = name
    }

    var rawValue: String {
        self.name.camelCase()
    }

    var isDefaultBrand: Bool {
        if DefaultBrands(rawValue: self.rawValue) != nil {
            return true
        } else {
            return false
        }
    }

    private enum CodingKeys: String, CodingKey {
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}
