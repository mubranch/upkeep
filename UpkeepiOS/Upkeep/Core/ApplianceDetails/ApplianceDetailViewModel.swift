//
//  ApplianceDetailViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

/// Adds identifable conformance to a URL allowing use of the .sheet(item: ...) view modifier
struct URLWrapper: Identifiable {
    let id = UUID()
    var url: URL
}

class ApplianceDetailViewModel: ObservableObject {
    @Bindable var appliance: Appliance
    @Published var shouldDismiss = false
    @Published var urlWrapper: URLWrapper?

    var isNewModel: Bool
    let modelContext: ModelContext
    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "ApplianceDetailViewModel")

    private var hasManualsSaved: Bool {
        let hasManuals = !appliance.manuals.isEmpty
        logger.logInfo("Checking if manuals are saved: \(hasManuals)")
        return hasManuals
    }

    init(appliance: Appliance, modelContext: ModelContext, isNewModel: Bool = false) {
        self.appliance = appliance
        self.isNewModel = isNewModel
        self.modelContext = modelContext
        logger.logInfo("Initialized ApplianceDetailViewModel with isNewModel: \(isNewModel)")
    }

    func buildUrlWrapper() {
        let baseURL = "https://www.manualslib.com/"
        if appliance.modelNumber.isEmpty {
            urlWrapper = URLWrapper(url: URL(string: baseURL)!)
            logger.logInfo("Built URL wrapper without model number.")
        } else {
            let modelFirstLetter = appliance.modelNumber.first!.lowercased()
            let modelURLString = "\(baseURL)\(modelFirstLetter)/\(appliance.modelNumber.lowercased()).html"
            if let modelURL = URL(string: modelURLString) {
                urlWrapper = URLWrapper(url: modelURL)
                logger.logInfo("Built URL wrapper for model number: \(appliance.modelNumber)")
            } else {
                logger.logError("Failed to create URL from model number: \(appliance.modelNumber)")
            }
        }
    }

    func deleteModel() {
        modelContext.delete(appliance)
        logger.logInfo("Deleted appliance with ID: \(appliance.id)")
        dismiss()
    }

    func dismiss() {
        shouldDismiss = true
        logger.logInfo("Dismiss action triggered.")
    }
}
