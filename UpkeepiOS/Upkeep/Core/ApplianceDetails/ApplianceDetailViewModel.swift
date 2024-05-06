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
    var modelContext: ModelContext
    
    private var hasManualsSaved: Bool {
        !appliance.manuals.isEmpty
    }
    
    init(appliance: Appliance, modelContext: ModelContext, isNewModel: Bool = false) {
        self.appliance = appliance
        self.isNewModel = isNewModel
        self.modelContext = modelContext
    }
    
    func buildUrlWrapper() {
        if appliance.modelNumber.isEmpty {
            urlWrapper = URLWrapper(url: URL(string: "https://www.manualslib.com/")!)
        } else {
            urlWrapper = URLWrapper(url: URL(string: "https://www.manualslib.com/\(appliance.modelNumber.first!.lowercased())/\(appliance.modelNumber.lowercased()).html")!)
        }
    }
    
    func deleteModel() {
        modelContext.delete(appliance)
        dismiss()
    }
    
    func dismiss() {
        shouldDismiss = true
    }
}
