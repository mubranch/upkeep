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
    var urlString: String
    var file: Data
    var appliance: Appliance?

    init(appliance: Appliance? = nil,
         name: String,
         urlString: String,
         file: Data)
    {
        self.appliance = appliance
        self.name = name
        self.urlString = urlString
        self.file = file
    }
}
