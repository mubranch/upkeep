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

    var modelContext: ModelContext

    init(manual: Manual,
         appliance: Appliance,
         modelContext: ModelContext)
    {
        self.manual = manual
        self.appliance = appliance
        self.modelContext = modelContext
    }

    func openManual() {
        isOpen = manual
    }

    func editManual() {
        isEditing = manual
    }

    func delete() {
        modelContext.delete(manual)
    }
}
