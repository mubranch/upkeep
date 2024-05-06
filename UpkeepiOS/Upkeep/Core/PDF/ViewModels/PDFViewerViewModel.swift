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

    init(manual: Manual) {
        self.manual = manual
    }

    func dismiss() { shouldDismiss = true }
}
