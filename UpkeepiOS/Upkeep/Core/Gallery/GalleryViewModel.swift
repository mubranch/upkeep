//
//  GalleryViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/5/24.
//

import Foundation
import SwiftData
import SwiftUI

class GalleryViewModel: ObservableObject {
    @Binding var filteredAppliances: [Appliance]

    @Published var selectedAppliance: Appliance?
    @Published var newAppliance: Appliance?
    @Published var isFetchingData = false

    let modelContext: ModelContext
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "GalleryViewModel")

    init(filterTarget: Binding<[Appliance]>, modelContext: ModelContext) {
        self._filteredAppliances = filterTarget
        self.modelContext = modelContext
        logger.logInfo("GalleryViewModel initialized")
    }

    func deleteAppliance(indexSet: IndexSet) {
        for index in indexSet {
            if filteredAppliances.indices.contains(index) {
                let applianceToDelete = filteredAppliances[index]
                modelContext.delete(applianceToDelete)
                logger.logInfo("Deleted appliance with ID: \(applianceToDelete.id)")
            } else {
                logger.logError("Attempted to delete an appliance at an out-of-range index: \(index)")
            }
        }
    }
}
