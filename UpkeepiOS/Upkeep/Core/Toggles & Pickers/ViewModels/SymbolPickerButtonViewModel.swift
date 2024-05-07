//
//  SymbolPickerButtonViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

class SymbolPickerButtonViewModel: ObservableObject {
    @Binding var appliance: Appliance

    @Published var isPickingImage = false

    init(appliance: Binding<Appliance>) {
        self._appliance = appliance
    }

    func openSheet() {
        isPickingImage.toggle()
    }
}
