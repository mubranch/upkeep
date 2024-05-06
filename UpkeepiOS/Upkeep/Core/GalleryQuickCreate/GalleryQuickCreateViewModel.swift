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
    @Published var shouldDimiss = false

    @Published var name: String = .none
    @Published var category: Category?
    @Published var brand: Brand?
    @Published var modelNumber: String = .none
    @Published var serialNumber: String = .none
    @Published var purchaseDate: Date = .now
    @Published var warrantyExpirationDate: Date = .now
    @Published var lastMaintenaceDate: Date = .now

    let modelContext: ModelContext
    var webManager: WebManager

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.webManager = WebManager(modelContext: modelContext)
        self.brands = modelContext.fetchData()
    }

    var searchButtonDisabled: Bool {
        modelNumber.isEmpty || brand == nil
    }

    func deleteAppliance() {
        shouldDimiss = true
        guard let appliance = newAppliance else {
            print("Appliance doesn't exist.")
            return
        }
        modelContext.delete(appliance)
        newAppliance = nil
    }

    func dismiss() {
        shouldDimiss = true
    }

    @MainActor
    func fetchData() async {
        isFetchingData = true

        guard let brand = brand else {
            return
        }

        guard let fetchResult = await webManager.fetchAppliance(brand: brand, modelNumber: modelNumber) else {
            newAppliance = nil
            return
        }

        isFetchingData = false

        newAppliance = Appliance(name: name,
                                 category: category,
                                 brand: fetchResult.brand,
                                 modelNumber: fetchResult.modelNumber,
                                 serialNumber: serialNumber,
                                 purchaseDate: purchaseDate,
                                 warrantyExpirationDate: warrantyExpirationDate,
                                 lastMaintenaceDate: lastMaintenaceDate)
        dismiss()
    }

    func fetchTestData() {
        guard let fetchResult = webManager.fetchApplianceTest() else {
            dismiss()
            isFetchingData = false
            return
        }
        newAppliance = fetchResult
    }
}
