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

    var modelContext: ModelContext

    init(filterTarget: Binding<[Appliance]>,
         modelContext: ModelContext)
    {
        self._filteredAppliances = filterTarget
        self.modelContext = modelContext
    }

    func deleteAppliance(indexSet: IndexSet) {
        _ = indexSet.map { modelContext.delete(filteredAppliances[$0]) }
    }
}
