//
//  Brand.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftData

protocol BrandProtocol: Identifiable, Codable {
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
        if DefaultBrand(rawValue: self.rawValue) != nil {
            return true
        } else {
            return false
        }
    }

    // Implementing Codable manually if you don't want to include 'formattedRawValue' in encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case name
    }

    // Implement init(from:) to decode the data.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }

    // Implement encode(to:) to encode the data.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}
