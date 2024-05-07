//
//  ManualItemViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

class ManualItemViewModel: ObservableObject {
    @Bindable var manual: Manual
    @Bindable var appliance: Appliance

    @Published var isOpen: Manual?
    @Published var isEditing: Manual?

    let modelContext: ModelContext
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "ManualItemViewModel")

    init(manual: Manual, appliance: Appliance, modelContext: ModelContext) {
        self.manual = manual
        self.appliance = appliance
        self.modelContext = modelContext
    }

    func openManual() {
        isOpen = manual
        logger.logInfo("Opened manual for appliance: \(appliance.name)")
    }

    func editManual() {
        isEditing = manual
        logger.logInfo("Editing manual for appliance: \(appliance.name)")
    }

    func deleteManual() {
        modelContext.delete(manual)
        logger.logInfo("Deleted manual for appliance: \(appliance.name)")
        isOpen = nil
        isEditing = nil
    }
}
