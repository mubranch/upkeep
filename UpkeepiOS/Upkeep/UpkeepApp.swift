//
//  UpkeepApp.swift
//  Upkeep
//
//  Created by Mustafa on 4/22/24.
//

import Foundation
import SwiftData
import SwiftUI

@main
struct UpkeepApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
        }
        .modelContainer(for: [Appliance.self, Manual.self, Brand.self, Category.self])
    }
}
