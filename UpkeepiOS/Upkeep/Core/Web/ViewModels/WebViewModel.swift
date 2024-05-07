//
//  WebViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import SwiftData
import SwiftUI

class WebViewModel: ObservableObject {
    @Bindable var appliance: Appliance
    @Published var shouldDismiss = false
    @Published var newManual: Manual?

    let modelContext: ModelContext
    var defaultUrl: URL

    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "WebViewModel")

    init(appliance: Appliance,
         modelContext: ModelContext,
         defaultUrl: URL)
    {
        self.appliance = appliance
        self.modelContext = modelContext
        self.defaultUrl = defaultUrl
    }

    func dismiss() { shouldDismiss.toggle() }
}
