//
//  GalleryQuickCreateViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/5/24.
//

import Foundation
import SwiftData
import SwiftUI

class GalleryQuickCreateViewModel: ObservableObject {
    @Published var brands = [Brand]()
    @Published var isFetchingData = false
    @Published var newAppliance: Appliance?
    @Published var shouldDismiss = false

    @Published var name: String = ""
    @Published var category: Category?
    @Published var brand: Brand?
    @Published var modelNumber: String = ""
    @Published var serialNumber: String = ""
    @Published var purchaseDate: Date = .now
    @Published var warrantyExpirationDate: Date = .now
    @Published var lastMaintenanceDate: Date = .now

    let modelContext: ModelContext
    var webManager: WebManager
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "GalleryQuickCreateViewModel")

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.webManager = WebManager(modelContext: modelContext)
        self.brands = modelContext.fetchData()
        logger.logInfo("ViewModel initialized and brands fetched")
    }

    var searchButtonDisabled: Bool {
        modelNumber.isEmpty || brand == nil
    }

    func deleteAppliance() {
        shouldDismiss = true
        guard let appliance = newAppliance else {
            logger.logError("Attempted to delete a non-existent appliance.")
            return
        }
        modelContext.delete(appliance)
        newAppliance = nil
        logger.logInfo("Appliance deleted")
    }

    func dismiss() {
        shouldDismiss = true
        logger.logInfo("Dismiss action triggered")
    }

    @MainActor
    func fetchData() async {
        isFetchingData = true
        logger.logInfo("Fetching data started")

        defer {
            isFetchingData = false
            logger.logInfo("Fetching data ended")
        }

        guard let brand = brand, !modelNumber.isEmpty else {
            logger.logError("Fetch aborted: Brand or model number not set")
            return
        }

        guard let fetchResult = await webManager.fetchAppliance(brand: brand, modelNumber: modelNumber) else {
            newAppliance = nil
            logger.logError("Failed to fetch appliance data")
            return
        }

        newAppliance = Appliance(name: name,
                                 category: category,
                                 brand: fetchResult.brand,
                                 modelNumber: fetchResult.modelNumber,
                                 serialNumber: serialNumber,
                                 purchaseDate: purchaseDate,
                                 warrantyExpirationDate: warrantyExpirationDate,
                                 lastMaintenanceDate: lastMaintenanceDate)
        dismiss()
    }

    func fetchTestData() {
        guard let fetchResult = webManager.fetchApplianceTest() else {
            dismiss()
            isFetchingData = false
            logger.logError("Test data fetch failed")
            return
        }
        newAppliance = fetchResult
        logger.logInfo("Test data fetched successfully")
    }
}
