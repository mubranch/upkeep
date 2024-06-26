//
//  String+Ext.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

extension String {
    static let none = ""
}

extension String? {
    var unwrapped: String {
        self ?? "unkown".capitalized
    }
}

extension String {
    func camelCase() -> String {
        let components = lowercased().components(separatedBy: "_")
        let camelCaseString = components.enumerated().map { index, component in
            // Capitalize all components except the first one
            index == 0 ? component : component.capitalized
        }.joined()
        return camelCaseString
    }
}

extension String {
    var betterHash: Int {
        var hash: UInt32 = 5381
        let byteScalars = utf8
        for byte in byteScalars {
            hash = 127 &* hash &+ UInt32(byte)
        }
        // Incorporate the length of the string into the hash calculation
        hash = hash &+ UInt32(count)
        return Int(hash)
    }

    func hashedToColor() -> Color {
        // Convert the string to a hash value
        let hashValue = betterHash
        // Use modulus to limit the value to a positive range
        var positiveHash = hashValue
        if positiveHash < 0 {
            positiveHash = -positiveHash
        }
        // Use modulus to limit the value to a range
        let colorIndex = positiveHash % 7 // Adjusted to the number of colors available
        // Define a set of colors
        let colors: [Color] = [.cyan, .purple, .indigo, .teal, .mint, .pink, .green, .blue, .orange]
        // Return the color corresponding to the index
        return colors[colorIndex]
    }
}
