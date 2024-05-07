//
//  MaintenanceManager.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

struct MaintenanceManager {
    @Bindable var appliance: Appliance

    private let logger: LogManager

    init(appliance: Appliance) {
        self.appliance = appliance
        self.logger = LogManager(subsystem: "com.upkeep.subsystem", category: "MaintenanceManager: \(appliance.id)")
    }

    /// Check clean date is overdue
    var isOverdue: Bool {
        appliance.lastMaintenaceDate < Date()
    }
}
