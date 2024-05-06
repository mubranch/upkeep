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

    var modelContext: ModelContext
    var defaultUrl: URL

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
