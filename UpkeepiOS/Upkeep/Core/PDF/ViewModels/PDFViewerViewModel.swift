//
//  PDFViewerViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

class PDFViewerViewModel: ObservableObject {
    @Bindable var manual: Manual
    @Published var shouldDismiss = false

    private let logger = LogManager(subsystem: "com.upkeep.subsystem", category: "PDFViewerViewModel")

    init(manual: Manual) {
        self.manual = manual
        logger.logInfo("Initialized PDF Viewer with manual ID: \(manual.id)")
    }

    func dismiss() {
        shouldDismiss = true
        logger.logInfo("Dismissed PDF Viewer for manual ID: \(manual.id)")
    }
}
