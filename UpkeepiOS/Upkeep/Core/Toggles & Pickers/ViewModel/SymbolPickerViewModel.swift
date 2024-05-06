//
//  SymbolPickerViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

class SymbolPickerViewModel: ObservableObject {
    @Binding var appliance: Appliance

    @Published var shouldDismiss = false

    init(appliance: Binding<Appliance>) {
        self._appliance = appliance
    }

    func dismiss() {
        shouldDismiss = true
    }

    func changeSymbol(_ symbol: DefaultSymbols) {
        appliance.symbol = symbol
        dismiss()
    }
}
