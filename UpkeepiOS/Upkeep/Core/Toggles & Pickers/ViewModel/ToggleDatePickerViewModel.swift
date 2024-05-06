//
//  ToggleDatePickerViewModel.swift
//  Upkeep
//
//  Created by Mustafa on 5/6/24.
//

import Foundation
import SwiftUI

class ToggleDatePickerViewModel: ObservableObject {
    @Binding var selection: Date

    init(selection: Binding<Date>) {
        self._selection = selection
    }
}
