//
//  ManualDetailViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

class ManualDetailViewModel: ObservableObject {
    @Bindable var appliance: Appliance
    @Bindable var manual: Manual

    @Published var shouldDismiss = false

    var appliances: [Appliance]
    let modelContext: ModelContext

    var saveIsDisabled: Bool {
        manual.name.isEmpty || manual.appliance == nil
    }

    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "ManualDetailViewModel")

    init(appliance: Appliance, manual: Manual, modelContext: ModelContext) {
        self.appliance = appliance
        self.manual = manual
        self.modelContext = modelContext
        self.appliances = modelContext.fetchData()
        self.manual.appliance = appliance
        logger.logInfo("Initialized with appliance ID: \(appliance.id) and manual ID: \(manual.id)")
    }

    func selectAppliance(appliance: Appliance) {
        manual.appliance = appliance
        logger.logInfo("Appliance selected: \(appliance.id) for manual ID: \(manual.id)")
    }

    func dismiss() {
        shouldDismiss = true
        logger.logInfo("Dismiss action triggered for manual ID: \(manual.id)")
    }

    func cancel() {
        modelContext.delete(manual)
        logger.logInfo("Manual deleted: \(manual.id)")
        dismiss()
    }

    func save() {
        modelContext.insert(manual)
        logger.logInfo("Manual saved: \(manual.id)")
        dismiss()
    }
}
