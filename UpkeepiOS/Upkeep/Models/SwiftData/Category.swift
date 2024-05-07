//
//  Category.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation
import SwiftData

protocol CategoryProtocol: Identifiable, Codable, Hashable {
    var title: String { get }
}

@Model
final class Category: Identifiable, Codable {
    @Attribute(.unique) var title: String
    private var appliances: [Appliance] = []

    init(title: String) {
        self.title = title.capitalized
    }

    var rawValue: String {
        title.camelCase()
    }

    var isDefaultCategory: Bool {
        if DefaultCategory(rawValue: rawValue) != nil {
            return true
        } else {
            return false
        }
    }

    private enum CodingKeys: String, CodingKey {
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
}
