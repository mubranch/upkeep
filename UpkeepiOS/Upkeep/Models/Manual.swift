//
//  Models.swift
//  Upkeep
//
//  Created by Mustafa on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Manual: Identifiable {
    var id = UUID().uuidString
    var name: String
    var type: String
    var file: Data
    var appliance: Appliance?

    init(appliance: Appliance? = nil,
         name: String,
         type: String,
         file: Data)
    {
        self.appliance = appliance
        self.name = name
        self.type = type
        self.file = file
    }
}
