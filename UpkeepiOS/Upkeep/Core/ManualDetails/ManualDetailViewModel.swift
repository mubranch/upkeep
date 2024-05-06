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
    var modelContext: ModelContext

    var saveIsDisabled: Bool {
        manual.name.isEmpty || manual.appliance == nil
    }

    init(appliance: Appliance,
         manual: Manual,
         modelContext: ModelContext)
    {
        self.appliance = appliance
        self.manual = manual
        self.modelContext = modelContext
        self.appliances = modelContext.fetchData()
        self.manual.appliance = appliance
    }

    func selectAppliance(appliance: Appliance) {
        manual.appliance = appliance
    }

    func dismiss() {
        shouldDismiss = true
    }

    func cancel() {
        modelContext.delete(manual)
        dismiss()
    }

    func save() {
        modelContext.insert(manual)
        dismiss()
    }
}
