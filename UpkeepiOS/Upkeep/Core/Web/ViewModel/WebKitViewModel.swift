//
//  WebKitViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftData
import SwiftUI

class WebKitViewModel: ObservableObject {
    @Binding var newManual: Manual?

    @Published var activeUrl: URL

    var modelContext: ModelContext

    init(newManual: Binding<Manual?>,
         activeUrl: URL,
         modelContext: ModelContext)
    {
        self._newManual = newManual
        self.activeUrl = activeUrl
        self.modelContext = modelContext
    }
}
