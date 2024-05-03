//
//  ApplianceEnumProtocol.swift
//  Upkeep
//
//  Created by Mustafa on 5/3/24.
//

import Foundation

protocol ApplianceEnumProtocol: Codable, CaseIterable, Hashable {
    var rawValue: String { get }
    static var title: String { get }
    var formattedRawValue: String { get }
}
